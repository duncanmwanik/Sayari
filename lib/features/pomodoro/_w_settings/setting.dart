import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/providers.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/abcs/buttons/color_button.dart';
import '../../../_widgets/others/color_menu.dart';
import '../../../_widgets/others/forms/numeric.dart';
import '../../../_widgets/others/text.dart';

class PomodoroSetting extends StatelessWidget {
  const PomodoroSetting({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // title
        AppText(size: normal, text: pomodoroTitles[type] ?? '---', fontWeight: FontWeight.w900),
        sph(),
        //
        Row(
          children: [
            // minutes input
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //
                  AppText(text: 'Minutes:'),
                  spw(),
                  NumericFormInput(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        state.pomodoro.updatedata('${type}t', value.trim().toString());
                      }
                    },
                    initialValue: state.pomodoro.data['${type}t'],
                    maxLength: 5,
                    hintText: '0',
                  ),
                  //
                ],
              ),
            ),
            //
            spw(),
            ColorButton(
              menuItems: colorMenu(
                selectedColor: state.pomodoro.data['${type}c'],
                onSelect: (newColor) => state.pomodoro.updatedata('${type}c', newColor),
              ),
              bgColor: state.pomodoro.data['${type}c'],
            ),
            //
          ],
        ),
        //
        if (type == 'l') sph(),
        if (type == 'l')
          Row(
            children: [
              //
              AppText(text: 'Interval :'),
              spw(),
              NumericFormInput(
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    state.pomodoro.updatedata('lbi', value.trim().toString());
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
