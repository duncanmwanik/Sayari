import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../__styling/variables.dart';
import '../../../_providers/common/pomodoro.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';

class PlayPauseTimer extends StatelessWidget {
  const PlayPauseTimer({super.key, required this.isCurrentTimer, this.onPressed});

  final bool isCurrentTimer;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Consumer<PomodoroProvider>(builder: (context, pomo, child) {
      return AppButton(
        onPressed: onPressed,
        isRound: true,
        color: white,
        padding: EdgeInsets.all(1.h),
        child: AppIcon(
          !pomo.isTiming || pomo.isPaused ? Icons.play_arrow_rounded : Icons.pause_rounded,
          size: 50,
          color: black,
        ),
      );
    });
  }
}
