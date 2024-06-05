import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../_helpers/_common/global.dart';
import '../../../../../_helpers/_common/navigation.dart';
import '../../../../../_providers/providers.dart';
import '../../../../../_variables/features.dart';
import '../../../../../_widgets/others/others/other_widgets.dart';
import '../../../../_tables/_helpers/common.dart';
import 'item_flag.dart';

class ItemFlagList extends StatelessWidget {
  const ItemFlagList(
      {super.key, required this.flagList, this.isTinyFlag = false, this.isMiniEdit = false, this.itemId, this.listId});

  final List flagList;
  final bool isTinyFlag;
  final bool isMiniEdit;
  final String? itemId;
  final String? listId;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
          spacing: 5,
          runSpacing: smallWidth(),
          children: List.generate(flagList.length, (index) {
            String flag = flagList[index] ?? 'missing*';

            // If the flag is not deleted
            if (Hive.box('${liveTable()}_${feature.flags.t}').containsKey(flag)) {
              return ItemFlag(
                flag: flag,
                isTinyFlag: isTinyFlag,
                onPressedDelete: () {
                  flagList.remove(flag);
                  state.input.update(action: 'add', key: 'g', value: getJoinedList(flagList));
                },
              );
            }
            // If not available, we remove the item flag from item data
            else {
              onBuildOperation(() {
                flagList.remove(flag);
                state.input.update(action: 'add', key: 'g', value: getJoinedList(flagList));
              });

              return NoWidget();
            }
          })),
    );
  }
}
