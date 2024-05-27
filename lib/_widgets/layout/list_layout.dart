import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../__styling/spacing.dart';
import '../../_helpers/_common/misc.dart';
import '../../_models/item.dart';
import '../../_providers/providers.dart';
import '../../features/_tables/_helpers/common.dart';
import '../items/list_item.dart';

class ListLayout extends StatelessWidget {
  const ListLayout({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    Box box = Hive.box('${liveTable()}_$type');

    return Padding(
      padding: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: largeHeightPlaceHolder()),
      child: ReorderableListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        onReorder: (oldIndex, newIndex) => doNothing(),
        // onReorder: (oldIndex, newIndex) => orderItems(
        //   type: type,
        //   itemId: state.data.chosen[oldIndex],
        //   itemsLength: state.data.chosen.length,
        //   oldIndex: oldIndex,
        //   newIndex: newIndex,
        // ),
        itemCount: state.data.chosen.length,
        itemBuilder: (context, index) {
          Item item = Item(type: type, id: state.data.chosen[index], data: box.get(state.data.chosen[index], defaultValue: {}));

          return ReorderableDelayedDragStartListener(
            index: index,
            key: ValueKey(item.id),
            child: ListItem(item: item),
          );
        },
      ),
    );
  }
}
