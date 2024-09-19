import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../_providers/pomodoro.dart';
import '../../../_variables/colors.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../sheet.dart';

class PomodoroIndicator extends StatefulWidget {
  const PomodoroIndicator({super.key});

  @override
  State<PomodoroIndicator> createState() => _PomodoroIndicatorState();
}

class _PomodoroIndicatorState extends State<PomodoroIndicator> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PomodoroProvider>(builder: (context, pomo, child) {
      return Visibility(
        visible: pomo.isTiming,
        child: Padding(
          padding: paddingM('r'),
          child: AppButton(
            onPressed: () => showPomodoroSheet(),
            tooltip: 'Open Pomodoro',
            isRound: true,
            showBorder: true,
            color: backgroundColors[pomo.data['${pomo.currentTimer}c']]!.color,
            child: AppIcon(Icons.timer),
          ),
        ),
      );
    });
  }
}
