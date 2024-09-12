// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'reorderable_grid.dart';
import 'typedefs.dart';

class ReorderableGridView extends StatefulWidget {
  const ReorderableGridView.builder({
    super.key,
    this.scrollDirection = Axis.vertical,
    required this.gridDelegate,
    required this.itemBuilder,
    required this.itemCount,
    required this.onReorder,
    this.itemDragEnable = _defaultItemDragEnable,
    this.proxyDecorator,
    this.onReorderStart,
  });

  final SliverGridDelegate gridDelegate;
  final Axis scrollDirection;
  final IndexedWidgetBuilder itemBuilder;
  final IndexedValueGetter<bool> itemDragEnable;
  final int itemCount;
  final ReorderCallback onReorder;
  final void Function(int index)? onReorderStart;
  final ReorderItemProxyDecorator? proxyDecorator;

  @override
  ReorderableGridViewState createState() => ReorderableGridViewState();

  static bool _defaultItemDragEnable(int index) => true;
}

class ReorderableGridViewState extends State<ReorderableGridView> {
  Widget _wrapWithSemantics(Widget child, int index) {
    void reorder(int startIndex, int endIndex) {
      if (startIndex != endIndex) {
        widget.onReorder(startIndex, endIndex);
      }
    }

    // First, determine which semantics actions apply.
    final Map<CustomSemanticsAction, VoidCallback> semanticsActions = <CustomSemanticsAction, VoidCallback>{};

    // Create the appropriate semantics actions.
    void moveToStart() => reorder(index, 0);
    void moveToEnd() => reorder(index, widget.itemCount);
    void moveBefore() => reorder(index, index - 1);
    // To move after, we go to index+2 because we are moving it to the space
    // before index+2, which is after the space at index+1.
    void moveAfter() => reorder(index, index + 2);

    final MaterialLocalizations localizations = MaterialLocalizations.of(context);

    // If the item can move to before its current position in the grid.
    if (index > 0) {
      semanticsActions[CustomSemanticsAction(label: localizations.reorderItemToStart)] = moveToStart;
      String reorderItemBefore = localizations.reorderItemUp;
      if (widget.scrollDirection == Axis.horizontal) {
        reorderItemBefore = Directionality.of(context) == TextDirection.ltr ? localizations.reorderItemLeft : localizations.reorderItemRight;
      }
      semanticsActions[CustomSemanticsAction(label: reorderItemBefore)] = moveBefore;
    }

    // If the item can move to after its current position in the grid.
    if (index < widget.itemCount - 1) {
      String reorderItemAfter = localizations.reorderItemDown;
      if (widget.scrollDirection == Axis.horizontal) {
        reorderItemAfter = Directionality.of(context) == TextDirection.ltr ? localizations.reorderItemRight : localizations.reorderItemLeft;
      }
      semanticsActions[CustomSemanticsAction(label: reorderItemAfter)] = moveAfter;
      semanticsActions[CustomSemanticsAction(label: localizations.reorderItemToEnd)] = moveToEnd;
    }

    // We pass toWrap with a GlobalKey into the item so that when it
    // gets dragged, the accessibility framework can preserve the selected
    // state of the dragging item.
    //
    // We also apply the relevant custom accessibility actions for moving the item
    // up, down, to the start, and to the end of the grid.
    return MergeSemantics(
      child: Semantics(
        customSemanticsActions: semanticsActions,
        child: child,
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final Widget item = widget.itemBuilder(context, index);

    final Widget itemWithSemantics = _wrapWithSemantics(item, index);
    final Key itemGlobalKey = _ReorderableGridViewChildGlobalKey(item.key!, this);
    final bool enable = widget.itemDragEnable(index);

    switch (Theme.of(context).platform) {
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      case TargetPlatform.macOS:
        return ReorderableGridDragStartListener(
          key: itemGlobalKey,
          index: index,
          enabled: enable,
          child: itemWithSemantics,
        );
      case TargetPlatform.iOS:
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return ReorderableGridDelayedDragStartListener(
          key: itemGlobalKey,
          index: index,
          enabled: enable,
          child: itemWithSemantics,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    assert(debugCheckHasOverlay(context));

    return CustomScrollView(
      scrollDirection: widget.scrollDirection,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.zero,
          sliver: SliverReorderableGrid(
            itemBuilder: _itemBuilder,
            gridDelegate: widget.gridDelegate,
            itemCount: widget.itemCount,
            onReorder: widget.onReorder,
            onReorderStart: widget.onReorderStart,
            proxyDecorator: widget.proxyDecorator,
            scrollDirection: widget.scrollDirection,
          ),
        ),
      ],
    );
  }
}

// A global key that takes its identity from the object and uses a value of a
// particular type to identify itself.
//
// The difference with GlobalObjectKey is that it uses [==] instead of [identical]
// of the objects used to generate widgets.
@optionalTypeArgs
class _ReorderableGridViewChildGlobalKey extends GlobalObjectKey {
  const _ReorderableGridViewChildGlobalKey(this.subKey, this.state) : super(subKey);

  final Key subKey;
  final State state;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is _ReorderableGridViewChildGlobalKey && other.subKey == subKey && other.state == state;
  }

  @override
  int get hashCode => Object.hash(subKey, state);
}
