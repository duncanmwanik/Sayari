import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/spacing.dart';
import '../../../_models/item.dart';
import '../../../_providers/_providers.dart';
import '../../../_services/hive/get_data.dart';
import '../../../_variables/features.dart';
import '../_helpers/order_items.dart';
import '../items/list_item.dart';

class ListLayout extends StatelessWidget {
  const ListLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return ReorderableWrap(
      key: UniqueKey(),
      maxMainAxisCount: 1,
      alignment: WrapAlignment.center,
      padding: padding(
        t: isSmallPC() ? mediumHeight() : null,
        b: largeHeightPlaceHolder(),
      ),
      onReorder: (oldIndex, newIndex) => orderItems(
        type: feature.notes,
        oldItemId: state.data.ids[oldIndex],
        newItemId: state.data.ids[newIndex],
        itemsLength: state.data.ids.length,
        oldIndex: oldIndex,
        newIndex: newIndex,
      ),
      children: List.generate(state.data.ids.length, (index) {
        String itemId = state.data.ids[index];
        Map itemData = storage(feature.notes).get(itemId, defaultValue: {});
        Item item = Item(type: feature.notes, id: itemId, data: itemData);

        return ReorderableDelayedDragStartListener(
          index: index,
          key: ValueKey(item.id),
          child: ListItem(item: item),
        );
      }),
    );
  }
}
