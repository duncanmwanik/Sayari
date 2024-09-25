import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/spacing.dart';
import '../../../_helpers/_common/helpers.dart';
import '../../../_models/item.dart';
import '../../../_providers/_providers.dart';
import '../../../_services/hive/get_data.dart';
import '../../../_variables/features.dart';
import '../_helpers/order_items.dart';
import '../note.dart';

class GridLayout extends StatelessWidget {
  const GridLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      bool isGrid = state.views.isGrid();

      return Align(
        alignment: Alignment.topCenter,
        child: ReorderableWrap(
          key: UniqueKey(),
          enableReorder: !isShare(),
          spacing: 12,
          runSpacing: 12,
          maxMainAxisCount: isGrid ? null : 1,
          needsLongPressDraggable: true,
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

            return Note(key: Key(item.id), item: item);
          }),
        ),
      );
    });
  }
}
