import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_models/item.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/order_items.dart';
import 'subitem.dart';

class ListOfSubItems extends StatelessWidget {
  const ListOfSubItems({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    Map subItemsData = item.subItems();
    List subItemsKeys = subItemsData.keys.toList();
    if (item.showNewEntriesFirst()) {
      subItemsKeys = subItemsKeys.reversed.toList();
    }

    return subItemsKeys.isNotEmpty
        ? ReorderableWrap(
            key: UniqueKey(),
            runSpacing: tinyHeight(),
            maxMainAxisCount: 1,
            padding: EdgeInsets.zero,
            needsLongPressDraggable: false,
            onReorder: (oldIndex, newIndex) => orderItems(
              parent: feature.notes,
              oldItemId: subItemsKeys[oldIndex],
              newItemId: subItemsKeys[newIndex],
              itemsLength: subItemsKeys.length,
              oldIndex: oldIndex,
              newIndex: newIndex,
            ),
            children: List.generate(subItemsKeys.length, (index) {
              Item sitem = Item(
                parent: feature.notes,
                id: item.id,
                sid: subItemsKeys[index],
                data: subItemsData[subItemsKeys[index]],
              );

              return SubItem(sitem: sitem, item: item);
            }),
          )
        : Padding(
            padding: paddingM(),
            child: AppText(text: 'No task items yet...', size: small, faded: true),
          );
  }
}
