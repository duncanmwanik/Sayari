import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/providers.dart';
import '../../../_variables/strings.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/abcs/buttons/color_button.dart';
import '../../../_widgets/others/color_menu.dart';
import '../../../_widgets/others/forms/numeric.dart';
import '../../../_widgets/others/text.dart';

// TODOs: code min

class PomodoroSetting extends StatelessWidget {
  const PomodoroSetting({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // title
        AppText(size: normal, text: pomodoroTitles[type] ?? '---', fontWeight: FontWeight.w900),
        //
        sph(),
        //
        Row(
          children: [
            //
            Flexible(
              child: AppButton(
                onPressed: () => focusNode.requestFocus(),
                smallLeftPadding: true,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    NumericFormInput(
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          state.pomodoro.updatePomodoroMap('${type}Time', value.trim().toString());
                        }
                      },
                      initialValue: state.pomodoro.pomodoroMap['${type}Time'],
                      maxLength: 5,
                      hintText: '0',
                      focusNode: focusNode,
                    ),
                    //
                    spw(),
                    //
                    AppText(text: 'Minutes'),
                    //
                  ],
                ),
              ),
            ),
            //
            spw(),
            //
            ColorButton(
              menuItems: colorMenu(
                selectedColor: state.pomodoro.pomodoroMap['${type}Color'],
                onSelect: (newColor) => state.pomodoro.updatePomodoroMap('${type}Color', newColor),
              ),
              bgColor: state.pomodoro.pomodoroMap['${type}Color'],
            ),
            //
          ],
        ),
        //
        if (type == 'longBreak') sph(),
        //
        if (type == 'longBreak')
          Row(
            children: [
              //
              AppText(
                text: 'Interval :',
              ),
              //
              spw(),
              //
              NumericFormInput(
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    state.pomodoro.updatePomodoroMap('${type}Interval', value.trim().toString());
                  }
                },
                initialValue: '4',
                maxLength: 1,
                hintText: '4',
              ),
              //
            ],
          ),
        //
      ],
    );
  }
}
