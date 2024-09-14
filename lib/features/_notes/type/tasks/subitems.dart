import 'package:flutter/material.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_models/item.dart';
import '../../../../_widgets/layout/orderables/background.dart';
import '../../../../_widgets/others/text.dart';
import '_w_item/subitem.dart';

// TODOs: code min

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
        ? ReorderableListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            buildDefaultDragHandles: false,
            proxyDecorator: (child, index, animation) => proxyDecorator(child, index, animation),
            onReorder: (oldIndex, newIndex) {},
            itemCount: subItemsData.length,
            itemBuilder: (ctx, index) {
              String subItemId = subItemsKeys[index];
              Map subItemData = subItemsData[subItemId];

              return ReorderableDelayedDragStartListener(
                index: index,
                key: ValueKey(subItemId),
                child: SubItem(subItemId: subItemId, subItemData: subItemData, item: item),
              );
            },
          )
        : Padding(
            padding: paddingM(),
            child: AppText(text: 'No task items yet...', size: small, faded: true),
          );
  }
}
