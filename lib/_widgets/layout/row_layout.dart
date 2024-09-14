import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../_models/item.dart';
import '../../_providers/providers.dart';
import '../../_services/hive/get_data.dart';
import '../../_variables/features.dart';
import '../../features/_notes/_helpers/order_items.dart';
import '../../features/_notes/note.dart';
import 'orderables/background.dart';

class RowLayout extends StatelessWidget {
  const RowLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return Align(
        alignment: Alignment.topLeft,
        child: ReorderableListView.builder(
          padding: EdgeInsets.only(bottom: largeHeightPlaceHolder()),
          shrinkWrap: true,
          buildDefaultDragHandles: false,
          proxyDecorator: (child, index, animation) => proxyDecorator(child, index, animation),
          onReorder: (oldIndex, newIndex) => orderItems(
            type: feature.items.t,
            oldItemId: state.data.ids[oldIndex],
            newItemId: state.data.ids[newIndex],
            itemsLength: state.data.ids.length,
            oldIndex: oldIndex,
            newIndex: newIndex,
          ),
          itemCount: state.data.ids.length,
          itemBuilder: (ctx, index) {
            String itemId = state.data.ids[index];
            Map itemData = storage(feature.items.t).get(state.data.ids[index], defaultValue: {});
            Item item = Item(type: feature.items.t, id: itemId, data: itemData);

            return ReorderableDelayedDragStartListener(
              index: index,
              key: ValueKey(item.id),
              child: Padding(
                padding: EdgeInsets.only(top: smallWidth()), // space between items
                child: Note(item: item),
              ),
            );

            //
          },
        ),
      );
    });
  }
}
