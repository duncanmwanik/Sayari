import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../_helpers/_common/misc.dart';
import '../../_helpers/_common/ui.dart';
import '../../_models/item.dart';
import '../../_providers/providers.dart';
import '../../_services/hive/get_data.dart';
import '../../_variables/features.dart';
import '../../features/_notes/items/list_item.dart';

class ListLayout extends StatelessWidget {
  const ListLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      shrinkWrap: true,
      physics: shareScrollPhysics(),
      buildDefaultDragHandles: false,
      padding: EdgeInsets.only(bottom: largeHeightPlaceHolder()),
      onReorder: (oldIndex, newIndex) => doNothing(),
      // onReorder: (oldIndex, newIndex) => orderItems(
      //   type: type,
      //   itemId: state.data.ids[oldIndex],
      //   itemsLength: state.data.ids.length,
      //   oldIndex: oldIndex,
      //   newIndex: newIndex,
      // ),
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
