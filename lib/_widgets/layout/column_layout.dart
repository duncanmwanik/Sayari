import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/spacing.dart';
import '../../_models/item.dart';
import '../../_providers/providers.dart';
import '../../_services/hive/get_data.dart';
import '../../_variables/features.dart';
import '../../features/_notes/_helpers/order_items.dart';
import '../../features/_notes/note.dart';
import '../others/others/snap_scroll_physics.dart';

class ColumnLayout extends StatelessWidget {
  const ColumnLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: padding(
        t: isSmallPC() ? mediumHeight() : null,
        r: 250 / 2,
      ),
      physics: isPhone() ? const SnapScrollPhysics(snapSize: 300) : null,
      child: ReorderableRow(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Map itemData = storage(feature.items.t).get(state.data.ids[index], defaultValue: {});
          Item item = Item(type: feature.items.t, id: itemId, data: itemData);

          return ReorderableDelayedDragStartListener(
            index: index,
            key: ValueKey(item.id),
            child: Padding(
              padding: EdgeInsets.only(left: index == 0 ? 0 : smallWidth()), // spaces between items
              child: Note(item: item),
            ),
          );
        }),
      ),
    );
  }
}
