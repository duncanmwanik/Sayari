import 'package:flutter/material.dart';

import '../../../_providers/_providers.dart';
import '../../../_theme/spacing.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/date_time/date_info.dart';
import '../_helpers/date_time/misc.dart';

class SessionTime extends StatelessWidget {
  const SessionTime({super.key, required this.startTime, required this.endTime});

  final String startTime;
  final String endTime;

  @override
  Widget build(BuildContext context) {
    String time = '${get12HourTimeFrom24HourTime(startTime, islonger: true)}'
        '${endTime.isNotEmpty ? ' - ${get12HourTimeFrom24HourTime(endTime, islonger: true)}' : ''} ';

    return Wrap(
      runSpacing: tinyHeight(),
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        // date
        AppText(text: getDayInfoFullNames(state.dateTime.selectedDate), faded: true),
        spw(),
        AppIcon(Icons.lens_rounded, size: 5, faded: true),
        spw(),
        // time
        AppText(text: time, faded: true),
        //
      ],
    );
  }
}
