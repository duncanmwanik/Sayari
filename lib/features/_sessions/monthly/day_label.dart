import 'package:flutter/material.dart';

import '../../../__styling/variables.dart';
import '../../../_helpers/date_time/date_info.dart';
import '../../../_helpers/date_time/misc.dart';
import '../../../_widgets/others/text.dart';

class MonthDayNumberLabel extends StatelessWidget {
  const MonthDayNumberLabel({super.key, required this.date});

  final DateInfo date;

  @override
  Widget build(BuildContext context) {
    bool isToday = date.isToday();
    bool isSelectedMonth = isCurrentMonth(date.dateTime);

    return Container(
      height: 20,
      width: 20,
      margin: EdgeInsets.only(top: 2, bottom: 2, right: 2),
      decoration: BoxDecoration(
        color: isToday ? styler.accentColor() : transparent,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(borderRadiusTiny)),
      ),
      child: Center(
        child: AppText(
          size: small,
          text: date.dayString(),
          fontWeight: isSelectedMonth ? FontWeight.w400 : FontWeight.w100,
          extraFaded: !isSelectedMonth,
          color: isToday ? white : null,
        ),
      ),
    );
  }
}
