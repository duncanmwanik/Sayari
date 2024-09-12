import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../_state/pomodoro_provider.dart';
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
          padding: itemPaddingMedium(right: true),
          child: AppButton(
            onPressed: () => showPomodoroSheet(),
            tooltip: 'Open Pomodoro',
            isRound: true,
            showBorder: true,
            color: styler.accentColor(3),
            child: AppIcon(Icons.timer, faded: true),
          ),
        ),
      );
    });
  }
}
