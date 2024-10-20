import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_theme/spacing.dart';
import '../../../_variables/colors.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../sheet.dart';
import '../state/pomodoro.dart';

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
        visible: pomo.isCounting,
        child: Padding(
          padding: padM('r'),
          child: AppButton(
            onPressed: () => showPomodoroSheet(),
            tooltip: 'Open Pomodoro',
            isRound: true,
            showBorder: true,
            borderColor: backgroundColors[pomo.data['${pomo.currentTimer}c']]!.color,
            child: AppIcon(Icons.timer, tiny: true),
          ),
        ),
      );
    });
  }
}
