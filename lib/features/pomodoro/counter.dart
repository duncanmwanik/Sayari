// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../__styling/spacing.dart';
import '../../__styling/styler.dart';
import '../../__styling/variables.dart';
import '../../_variables/colors.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';
import '../calendar/_helpers/date_time/misc.dart';
import '_helpers/helpers.dart';
import 'state/pomodoro.dart';
import 'w/pause_play_btn.dart';

class PomodoroCounter extends StatelessWidget {
  const PomodoroCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PomodoroProvider>(builder: (context, pomo, child) {
      String type = pomo.currentTimer;
      Duration timer = Duration(minutes: int.parse(pomo.data['${type}t'] ?? '1'));
      int passedTime = (timer.inSeconds - pomo.remainingTime).toInt();
      bool isTiming = pomo.isTiming;
      Color color = backgroundColors[pomo.data['${type}c']]!.color;

      return Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 400, maxHeight: 400),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              //
              AppButton(
                height: 70.w,
                width: 70.w,
                customBorder: CircleBorder(),
                padding: EdgeInsets.all(15),
                color: styler.appColor(1),
                child: AppButton(
                  isRound: true,
                  padding: EdgeInsets.all(16),
                  color: styler.appColor(0.5),
                  customBorder: CircleBorder(),
                  child: CircularProgressIndicator(
                    strokeWidth: 17,
                    strokeCap: StrokeCap.round,
                    backgroundColor: color.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation(color),
                    value: isTiming ? ((passedTime == timer.inSeconds ? 1 : passedTime) / timer.inSeconds) : 0,
                  ),
                ),
              ),
              //
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // remaining Time
                  AppText(
                    size: 40,
                    text: isTiming ? getRemainingTimeString() : getTimerString(timer),
                    weight: FontWeight.w900,
                    color: !isTiming && pomo.isTiming ? AppColors.darkTextFaded : AppColors.darkText,
                  ),
                  // stopping time
                  tph(),
                  HtmlText(
                    text: pomo.isTiming
                        ? 'Stops at <b>${get12HourTimeFrom24HourTime(
                            getTimePartFromTimeOfDay(TimeOfDay.fromDateTime(pomo.end)),
                            showSeconds: true,
                            islonger: true,
                          )}</b>'
                        : '...',
                    color: !pomo.isTiming ? AppColors.darkTextExtraFaded : AppColors.darkText,
                  ),
                  // pause/play
                  mph(),
                  PlayPauseTimer(
                    onPressed: () => playPauseTimer(type),
                    isCurrentTimer: isTiming,
                  ),
                  // stop
                  sph(),
                  AppButton(
                    onPressed: pomo.isTiming ? () => pomo.reset() : null,
                    noStyling: true,
                    isRound: true,
                    child: AppIcon(Icons.stop_rounded, size: 30, color: !pomo.isTiming ? AppColors.darkTextExtraFaded : AppColors.darkText),
                  ),
                  //
                ],
              )
              //
            ],
          ),
        ),
      );
    });
  }
}
