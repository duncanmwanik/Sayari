import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../_helpers/_common/global.dart';
import '../../../../../_providers/_providers.dart';
import '../../../../../_variables/features.dart';
import '../../../../../_widgets/others/others/other.dart';
import '../../../../_spaces/_helpers/common.dart';
import 'item_flag.dart';

class ItemFlagList extends StatelessWidget {
  const ItemFlagList({super.key, required this.flagList, this.isTinyFlag = false, this.isMiniEdit = false, this.itemId, this.listId});

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
          runSpacing: 2,
          children: List.generate(flagList.length, (index) {
            String flag = flagList[index] ?? 'missing*';

            // If the flag is not deleted
            if (Hive.box('${liveSpace()}_${feature.flags}').containsKey(flag)) {
              return Padding(
                padding: padding(p: 2, s: 'r'),
                child: ItemFlag(
                  flag: flag,
                  isTinyFlag: isTinyFlag,
                  onPressedDelete: () {
                    flagList.remove(flag);
                    state.input.update('g', getJoinedList(flagList));
                  },
                ),
              );
            }
            // If not available, we remove the item flag from item data
            else {
              removeFlag(flag);
              return NoWidget();
            }
          })),
    );
  }

  Future<void> removeFlag(String flag) async {
    await Future.delayed(Duration.zero);
    flagList.remove(flag);
    state.input.update('g', getJoinedList(flagList));
  }
}
