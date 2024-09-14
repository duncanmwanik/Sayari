import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

import '../../__styling/spacing.dart';
import '../../_models/item.dart';
import '../../_providers/providers.dart';
import '../../_services/hive/get_data.dart';
import '../../_variables/features.dart';
import '../../features/_notes/_helpers/order_items.dart';
import '../../features/_notes/note.dart';

class GridLayout extends StatelessWidget {
  const GridLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      // double width = constraints.maxWidth; // remove this

      return ReorderableWrap(
        key: UniqueKey(),
        spacing: smallWidth(),
        runSpacing: smallWidth(),
        needsLongPressDraggable: true,
        padding: EdgeInsets.only(bottom: largeHeightPlaceHolder()),
        onReorder: (oldIndex, newIndex) => orderItems(
          type: feature.items.t,
          oldItemId: state.data.ids[oldIndex],
          newItemId: state.data.ids[newIndex],
          itemsLength: state.data.ids.length,
          oldIndex: oldIndex,
          newIndex: newIndex,
        ),
        children: List.generate(state.data.ids.length, (index) {
          String itemId = state.data.ids[index];
          Map itemData = storage(feature.items.t).get(itemId, defaultValue: {});
          Item item = Item(type: feature.items.t, id: itemId, data: itemData);

          return Note(key: Key(item.id), item: item);
        }),
      );
    });
  }
}
