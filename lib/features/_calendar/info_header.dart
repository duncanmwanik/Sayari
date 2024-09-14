import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/date_time/date_info.dart';
import '../../_helpers/date_time/jump_to_date.dart';
import '../../_providers/common/datetime.dart';
import '../../_providers/common/views.dart';
import '../../_widgets/buttons/buttons.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';
import '_helpers/swipe.dart';
import '_w/calendar_options.dart';

class InfoHeader extends StatelessWidget {
  const InfoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<DateTimeProvider, ViewsProvider>(builder: (context, dates, views, child) {
      DateInfo date = DateInfo(dates.selectedDate);
      bool isToday = [date.isToday(), false, date.isCurrentMonth(), date.isCurrentYear()][views.calendarView];
      date.isToday_ = isToday;
      List infoList = [
        getDayInfo(dates.selectedDate),
        getWeekInfo(dates.currentWeekDates[0], dates.currentWeekDates[6]),
        getMonthInfo(dates.selectedYear, dates.selectedMonth),
        dates.selectedYear.toString(),
      ];

      return Container(
        padding: paddingM(isSmallPC() ? 'l' : 'lr'),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //
                  // previous date
                  if (kIsWeb)
                    AppButton(
                      noStyling: true,
                      tooltip: 'Previous',
                      isRound: true,
                      child: AppIcon(Icons.keyboard_arrow_left, size: 18, faded: true),
                      onPressed: () => swipeToNew(direction: 'left'),
                    ),
                  pw(3),
                  //
                  // date info
                  Flexible(
                    child: AppButton(
                      onPressed: () => jumpToDateDialog(),
                      menuItems: isPhone() ? null : jumpToDateMenu(initialDate: date.date),
                      tooltip: 'Go to date',
                      noStyling: true,
                      padding: zeroPadding,
                      hoverColor: transparent,
                      child: FittedBox(
                          child: AppText(
                        size: extra,
                        text: infoList[views.calendarView],
                        fontWeight: FontWeight.w800,
                        faded: true,
                      )),
                    ),
                  ),
                  //
                  // next date
                  pw(3),
                  if (kIsWeb)
                    AppButton(
                      noStyling: true,
                      tooltip: 'Next',
                      isRound: true,
                      child: AppIcon(Icons.keyboard_arrow_right, size: 18, faded: true),
                      onPressed: () => swipeToNew(direction: 'right'),
                    ),
                  //
                ],
              ),
            ),
            //
            Flexible(child: CalendarOptions(date: date)),
            //
          ],
        ),
      );
    });
  }
}
