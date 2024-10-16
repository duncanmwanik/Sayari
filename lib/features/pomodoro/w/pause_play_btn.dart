import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../state/pomodoro.dart';

class PlayPauseTimer extends StatelessWidget {
  const PlayPauseTimer({super.key, required this.isCurrentTimer, this.onPressed});

  final bool isCurrentTimer;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Consumer<PomodoroProvider>(builder: (context, pomo, child) {
      return Wrap(
        spacing: smallWidth(),
        children: [
          // pause/play
          AppButton(
            onPressed: onPressed,
            isRound: true,
            color: white,
            child: AppIcon(
              !pomo.isCounting || pomo.isPaused ? Icons.play_arrow_rounded : Icons.pause_rounded,
              color: black,
            ),
          ),
          // reset
          AppButton(
            onPressed: pomo.isCounting ? () => pomo.reset() : null,
            isRound: true,
            borderRadius: borderRadiusLarge,
            child: AppIcon(Icons.restart_alt, extraFaded: !pomo.isCounting),
          ),
        ],
      );
    });
  }
}
