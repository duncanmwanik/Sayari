import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/others/text.dart';
import '_state/pomodoro_provider.dart';
import 'type.dart';

class PomodoroChooser extends StatelessWidget {
  const PomodoroChooser({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PomodoroProvider>(builder: (context, pomo, child) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          sph(),
          AppText(text: 'pomodoro', size: 30, fontWeight: FontWeight.w800, faded: true),
          elph(),
          //
          AppButton(
            padding: EdgeInsets.all(5),
            borderRadius: borderRadiusLarge,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // focus
                PomodoroType(type: 'f'),
                // short break
                PomodoroType(type: 's'),
                // long break
                PomodoroType(type: 'l'),
                //
              ],
            ),
          ),
        ],
      );
    });
  }
}
