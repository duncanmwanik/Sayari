import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_variables/colors.dart';
import '../../_variables/strings.dart';
import '../../_widgets/others/text.dart';
import '_helpers/helpers.dart';
import '_state/pomodoro_provider.dart';
import '_w_period/pause_play_btn.dart';
import '_w_period/time_to_stop.dart';

class PomodoroPeriod extends StatelessWidget {
  const PomodoroPeriod({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    return Consumer<PomodoroProvider>(builder: (context, pomo, child) {
      Map typeRemainingTimes = {
        'focus': pomo.remainingTimeFocus,
        'shortBreak': pomo.remainingTimeBreak,
        'longBreak': pomo.remainingTimeLongBreak
      };

      Duration timer = Duration(minutes: int.parse(pomo.pomodoroMap['${type}Time'] ?? '1'));
      bool isCurrentTimer = pomo.currentTimer == type;
      int passedTime = (timer.inSeconds - typeRemainingTimes[type]).toInt();

      return InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(borderRadiusMediumSmall + 2),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColors[pomo.pomodoroMap['${type}Color']]!.color.withOpacity(
                  pomo.isTiming
                      ? isCurrentTimer
                          ? 0.2
                          : 0.1
                      : 0.6,
                ),
            borderRadius: BorderRadius.circular(borderRadiusMediumSmall),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadiusMediumSmall - 2),
            child: Stack(
              children: [
                //
                //
                LayoutBuilder(builder: (BuildContext ctx, BoxConstraints constraints) {
                  double width = constraints.maxWidth;

                  return Container(
                    height: 150,
                    width: isCurrentTimer
                        ? width * ((passedTime == timer.inSeconds ? 1 : passedTime) / timer.inSeconds)
                        : 0,
                    decoration: BoxDecoration(color: backgroundColors[pomo.pomodoroMap['${type}Color']]!.color),
                  );
                }),
                //
                //
                Container(
                  height: 150,
                  padding: const EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 15),
                  decoration: BoxDecoration(
                    color: transparent,
                    borderRadius: BorderRadius.circular(borderRadiusMediumSmall),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // title
                                Flexible(
                                    child: AppText(
                                        size: extra, text: pomodoroTitles[type] ?? '-', fontWeight: FontWeight.w900)),
                                //
                                sph(),
                                //
                                // remaining Time
                                Flexible(
                                    child: AppText(
                                  size: pomodoro,
                                  text: isCurrentTimer ? getRemainingTimeString() : getTimerString(timer),
                                  fontWeight: FontWeight.w900,
                                )),
                                //
                              ],
                            ),
                          ),
                          //
                          PlayPauseTimer(
                            onPressed: () => manageTimer(type, timer, typeRemainingTimes[type]),
                            isCurrentTimer: isCurrentTimer,
                          ),
                          //
                        ],
                      ),
                      //
                      TimeToEnd(isCurrentTimer: isCurrentTimer, timeToEnd: pomo.end),
                      //
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
