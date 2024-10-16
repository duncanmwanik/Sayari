import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/others/text.dart';
import 'state/pomodoro.dart';
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
          AppText(text: 'pomodoro', size: 30, weight: FontWeight.bold, faded: true),
          mph(),
          //
          AppButton(
            padding: paddingS(),
            borderRadius: borderRadiusLarge,
            child: Wrap(
              spacing: tinyWidth(),
              runSpacing: tinyWidth(),
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
