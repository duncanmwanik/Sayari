import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/variables.dart';
import '../../../_widgets/others/icons.dart';
import '../_state/pomodoro_provider.dart';

class PlayPauseTimer extends StatelessWidget {
  const PlayPauseTimer({super.key, required this.isCurrentTimer, this.onPressed});

  final bool isCurrentTimer;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Consumer<PomodoroProvider>(builder: (context, pomo, child) {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.zero,
          backgroundColor: white,
          disabledBackgroundColor: transparent,
          minimumSize: Size(0, 0),
          fixedSize: Size(70, 70),
          side: BorderSide.none,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: AppIcon(
          isCurrentTimer
              ? pomo.isPaused
                  ? Icons.play_arrow_rounded
                  : Icons.pause_rounded
              : Icons.play_arrow_rounded,
          size: isCurrentTimer
              ? pomo.isPaused
                  ? 70
                  : 50
              : 70,
          color: black,
        ),
      );
    });
  }
}
