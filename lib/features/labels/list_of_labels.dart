import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../__styling/helpers.dart';
import '../../__styling/spacing.dart';
import '../../_helpers/_common/global.dart';
import '../../_providers/common/input.dart';
import '../../_providers/providers.dart';
import '../../_variables/features.dart';
import '../../_widgets/buttons/buttons.dart';
import '../../_widgets/others/others/other_widgets.dart';
import '../../_widgets/others/text.dart';
import '../_notes/_helpers/quick_edit.dart';
import '../_spaces/_helpers/common.dart';
import 'menu.dart';

class LabelList extends StatelessWidget {
  const LabelList({super.key, this.type, this.labels, this.bgColor, this.itemId});

  final String? type;
  final String? labels;
  final String? bgColor;
  final String? itemId;

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      String type_ = type ?? input.type;
      List labelList = getSplitList(labels ?? state.input.data['l']);

      Future<void> removeLabel(String label) async {
        await Future.delayed(Duration.zero);
        labelList.remove(label);

        if (itemId != null) {
          await editItemExtras(type: type_, itemId: itemId!, key: 'l', value: getJoinedList(labelList));
        } else {
          state.input.update(action: 'add', key: 'l', value: getJoinedList(labelList));
        }
      }

      return Visibility(
        visible: labelList.isNotEmpty,
        child: Padding(
          padding: paddingM('t'),
          child: Wrap(
              spacing: tinyWidth(),
              runSpacing: tinyWidth(),
              children: List.generate(labelList.length, (index) {
                String label = labelList[index];

                if (Hive.box('${liveSpace()}_${feature.labels.t}').containsKey(label)) {
                  // label
                  return AppButton(
                    menuItems: labelsMenu(
                      isSelection: true,
                      alreadySelected: labelList,
                      onDone: (newLabels) async {
                        labels != null
                            ? await editItemExtras(type: type_, itemId: itemId!, key: 'l', value: getJoinedList(newLabels))
                            : state.input.update(action: 'add', key: 'l', value: getJoinedList(newLabels));
                      },
                    ),
                    color: hasColour(bgColor) ? Colors.white24 : null,
                    smallVerticalPadding: true,
                    child: AppText(size: 11, text: label, bgColor: bgColor, fontWeight: FontWeight.bold),
                  );
                }
                // if label is missing
                else {
                  removeLabel(label);
                  return NoWidget();
                }
              })),
        ),
      );
    });
  }
}
