import 'package:flutter/material.dart';

import '../../../_theme/variables.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/date_time/date_info.dart';
import '../_helpers/date_time/misc.dart';

class YearViewTitleInput extends StatelessWidget {
  const YearViewTitleInput({super.key, required this.date});

  final DateItem date;

  @override
  Widget build(BuildContext context) {
    bool isToday = date.isToday();
    bool isSelectedMonth = isCurrentMonth(date.date);

    return Container(
      height: 20,
      width: 20,
      margin: EdgeInsets.only(top: 2, bottom: 2),
      decoration: BoxDecoration(
        color: isToday ? styler.accentColor() : transparent,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: AppText(
          size: small,
          text: date.day().toString(),
          weight: isSelectedMonth ? FontWeight.w600 : null,
          faded: !isSelectedMonth,
          color: isToday ? white : null,
        ),
      ),
    );
  }
}
