import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../_helpers/_common/ui.dart';
import '../../_models/item.dart';
import '../../_providers/providers.dart';
import '../../_services/hive/get_data.dart';
import '../../_variables/features.dart';
import '../../features/_notes/_helpers/order_items.dart';
import '../../features/_notes/items/list_item.dart';

class ListLayout extends StatelessWidget {
  const ListLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      shrinkWrap: true,
      physics: shareScrollPhysics(),
      buildDefaultDragHandles: false,
      padding: EdgeInsets.only(bottom: smallHeightPlaceHolder()),
      onReorder: (oldIndex, newIndex) => orderItems(
          type: feature.items.t,
          oldItemId: state.data.ids[oldIndex],
          newItemId: state.data.ids[newIndex],
          itemsLength: state.data.ids.length,
          oldIndex: oldIndex,
          newIndex: newIndex,
          applyIndexFix: true),
      itemCount: state.data.ids.length,
      itemBuilder: (context, index) {
        Item item = Item(
          type: feature.items.t,
          id: state.data.ids[index],
          data: storage(feature.items.t).get(state.data.ids[index], defaultValue: {}),
        );

        return ReorderableDelayedDragStartListener(
          index: index,
          key: ValueKey(item.id),
          child: ListItem(item: item),
        );
      },
    );
  }
}
