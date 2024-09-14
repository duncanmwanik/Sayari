import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/spacing.dart';
import '../../_models/item.dart';
import '../../_providers/providers.dart';
import '../../_services/hive/get_data.dart';
import '../../_variables/features.dart';
import '../../features/_notes/_helpers/order_items.dart';
import '../../features/_notes/note.dart';
import '../others/others/snap_scroll_physics.dart';
import 'orderables/background.dart';

class ColumnLayout extends StatelessWidget {
  const ColumnLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      double height = constraints.maxHeight;

      return Align(
        alignment: Alignment.topLeft,
        child: SizedBox(
          height: height,
          child: ReorderableListView.builder(
            scrollDirection: Axis.horizontal,
            physics: kIsWeb ? null : const SnapScrollPhysics(snapSize: 300),
            padding: EdgeInsets.only(right: isSmallPC() ? 100.w / 6 : 100.w - 320),
            itemExtent: 265,
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
                  // spaces between items
                  padding: EdgeInsets.only(left: index == 0 ? 0 : smallWidth()),
                  child: Note(item: item),
                ),
              );

              //
            },
          ),
        ),
      );
    });
  }
}
