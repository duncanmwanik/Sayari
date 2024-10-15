import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/spacing.dart';
import '../../../_helpers/helpers.dart';
import '../../../_models/item.dart';
import '../../../_providers/_providers.dart';
import '../../../_services/hive/store.dart';
import '../../../_variables/features.dart';
import '../_helpers/order_items.dart';
import '../note.dart';

class GridLayout extends StatelessWidget {
  const GridLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      bool isGrid = state.views.isGrid();

      return SizedBox(
        width: double.maxFinite,
        child: ReorderableWrap(
          alignment: isGrid ? WrapAlignment.start : WrapAlignment.center,
          key: UniqueKey(),
          enableReorder: !isShare(),
          ignorePrimaryScrollController: true,
          spacing: 12,
          runSpacing: 12,
          maxMainAxisCount: isGrid ? null : 1,
          padding: padding(
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

            return Note(key: Key(item.id), item: item);
          }),
        ),
      );
    });
  }
}
