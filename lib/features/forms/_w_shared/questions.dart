import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/global.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/checkbox.dart';
import '../../../_widgets/others/text.dart';
import '../../../_widgets/others/toast.dart';

class Questions extends StatefulWidget {
  const Questions({super.key, required this.tableId, required this.itemId, required this.data});

  final String tableId;
  final String itemId;
  final Map data;

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  List submission = [];

  @override
  Widget build(BuildContext context) {
    List questionKeys = getSplitList(widget.data['qo']);

    return Wrap(
      runSpacing: smallHeight(),
      children: List.generate(questionKeys.length, (index) {
        Map questionsData = jsonDecode(widget.data[questionKeys[index]] ?? '{}');
        String question = questionsData['qt'] ?? '---';
        List choices = getSplitList(questionsData['qc']);

        return AppButton(
          borderRadius: borderRadiusMediumSmall,
          padding: itemPaddingMedium(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(text: question, size: normal),
              sph(),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(choices.length, (index) {
                  String choice = choices[index];
                  bool isSelected = true;

                  return AppButton(
                    onPressed: () => showToast(3, choice),
                    borderRadius: borderRadiusMediumSmall,
                    padding: itemPaddingMedium(),
                    child: Row(
                      children: [
                        AppCheckBox(isChecked: isSelected),
                        spw(),
                        Expanded(child: AppText(text: question, size: normal)),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      }),
    );
  }
}
