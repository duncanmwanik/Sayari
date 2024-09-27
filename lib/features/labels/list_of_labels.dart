import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/helpers.dart';
import '../../__styling/spacing.dart';
import '../../_helpers/global.dart';
import '../../_providers/_providers.dart';
import '../../_providers/input.dart';
import '../../_services/hive/get_data.dart';
import '../../_variables/features.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/others/others/other.dart';
import '../../_widgets/others/text.dart';
import '../_notes/_helpers/quick_edit.dart';
import 'menu.dart';

class LabelList extends StatelessWidget {
  const LabelList({super.key, this.labels, this.bgColor, this.id});

  final String? labels;
  final String? bgColor;
  final String? id;

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      List labelList = splitList(labels ?? state.input.item.data['l']);

      Future<void> removeLabel(String label) async {
        await Future.delayed(Duration.zero);
        labelList.remove(label);

        if (id != null) {
          await editItemExtras(parent: feature.notes, id: id!, key: 'l', value: joinList(labelList));
        } else {
          state.input.update('l', joinList(labelList));
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

                if (storage(feature.labels).containsKey(label)) {
                  // label
                  return AppButton(
                    menuItems: labelsMenu(
                      isSelection: true,
                      alreadySelected: labelList,
                      onDone: (newLabels) async {
                        labels != null
                            ? await editItemExtras(parent: feature.notes, id: id!, key: 'l', value: joinList(newLabels))
                            : state.input.update('l', joinList(newLabels));
                      },
                    ),
                    color: hasColour(bgColor) ? Colors.white24 : null,
                    smallVerticalPadding: true,
                    child: AppText(size: 11, text: label, bgColor: bgColor),
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
