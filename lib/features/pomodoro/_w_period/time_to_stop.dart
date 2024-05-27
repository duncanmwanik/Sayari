import 'package:flutter/material.dart';

import '../../../_helpers/date_time/misc.dart';
import '../../../_widgets/others/text.dart';

class TimeToEnd extends StatelessWidget {
  const TimeToEnd({super.key, required this.isCurrentTimer, required this.timeToEnd});

  final bool isCurrentTimer;
  final DateTime timeToEnd;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //
        Flexible(
          child: Row(
            children: [
              AppText(
                text: 'Stops at ',
                color: isCurrentTimer ? null : Colors.transparent,
              ),
              Flexible(
                  child: AppText(
                text: isCurrentTimer
                    ? get12HourTimeFrom24HourTime(
                        getTimePartFromTimeOfDay(TimeOfDay.fromDateTime(timeToEnd)),
                        showSeconds: true,
                        islonger: true,
                      )
                    : '-',
                fontWeight: FontWeight.w900,
                color: isCurrentTimer ? null : Colors.transparent,
              )),
            ],
          ),
        ),
        //
      ],
    );
  }
}
