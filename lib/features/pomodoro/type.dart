import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/helpers.dart';
import '../../__styling/variables.dart';
import '../../_providers/common/pomodoro.dart';
import '../../_variables/colors.dart';
import '../../_variables/constants.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/others/text.dart';
import '_helpers/helpers.dart';

class PomodoroType extends StatelessWidget {
  const PomodoroType({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    return Consumer<PomodoroProvider>(builder: (context, pomo, child) {
      bool isCurrent = pomo.currentTimer == type;

      return AppButton(
        onPressed: () => startTimer(type),
        width: 150,
        borderRadius: borderRadiusLarge,
        noStyling: !isCurrent,
        color: backgroundColors[pomo.data['${type}c']]!.color,
        child: AppText(
          text: pomodoroTitles[type] ?? 'focus',
          size: normal,
          color: !isDark() && isCurrent ? white : null,
          weight: FontWeight.bold,
          textAlign: TextAlign.center,
        ),
      );
    });
  }
}
