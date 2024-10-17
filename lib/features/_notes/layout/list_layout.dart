import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

import '../../../_models/item.dart';
import '../../../_providers/_providers.dart';
import '../../../_services/hive/store.dart';
import '../../../_theme/breakpoints.dart';
import '../../../_theme/spacing.dart';
import '../../../_variables/features.dart';
import '../_helpers/order_items.dart';
import '../w/list_item.dart';

class ListLayout extends StatelessWidget {
  const ListLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return ReorderableWrap(
      key: UniqueKey(),
      ignorePrimaryScrollController: true,
      maxMainAxisCount: 1,
      alignment: WrapAlignment.center,
      padding: pad(
        t: isSmallPC() ? mediumHeight() : null,
        b: largeHeight(),
      ),
      onReorder: (oldIndex, newIndex) => orderItems(
        oldItemId: state.data.ids[oldIndex],
        newItemId: state.data.ids[newIndex],
        itemsLength: state.data.ids.length,
        oldIndex: oldIndex,
        newIndex: newIndex,
      ),
      children: List.generate(state.data.ids.length, (index) {
        Item item = Item(
          parent: feature.notes,
          id: state.data.ids[index],
          data: storage(feature.notes).get(state.data.ids[index], defaultValue: {}),
        );

        return ReorderableDelayedDragStartListener(
          index: index,
          key: ValueKey(item.id),
          child: ListItem(item: item),
        );
      }),
    );
  }
}
