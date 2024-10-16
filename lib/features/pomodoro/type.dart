import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/helpers.dart';
import '../../__styling/variables.dart';
import '../../_variables/colors.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/others/text.dart';
import 'state/pomodoro.dart';
import 'var/variables.dart';

class PomodoroType extends StatelessWidget {
  const PomodoroType({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    return Consumer<PomodoroProvider>(builder: (context, pomo, child) {
      bool isCurrent = pomo.currentTimer == type;

      return AppButton(
        onPressed: () => pomo.reset(type),
        width: 120,
        borderRadius: borderRadiusLarge,
        color: isCurrent ? backgroundColors[pomo.data['${type}c']]!.color : styler.appColor(1),
        child: AppText(
          text: pomodoroTitles[type] ?? 'focus',
          faded: !isCurrent,
          color: !isDark() && isCurrent ? white : null,
          weight: isCurrent ? FontWeight.w600 : null,
          textAlign: TextAlign.center,
        ),
      );
    });
  }
}
