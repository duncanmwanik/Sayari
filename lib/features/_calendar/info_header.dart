import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/_common/navigation.dart';
import '../../_helpers/date_time/date_info.dart';
import '../../_helpers/date_time/jump_to_date.dart';
import '../../_helpers/date_time/misc.dart';
import '../../_providers/common/datetime.dart';
import '../../_providers/common/views.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/sfcalendar.dart';
import '../../_widgets/others/text.dart';
import '_helpers/swipe.dart';
import '_w/view_chooser.dart';

class InfoHeader extends StatelessWidget {
  const InfoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<DateTimeProvider, ViewsProvider>(builder: (context, dates, views, child) {
      DateInfo date = DateInfo(dates.selectedDate);
      bool isToday = [date.isToday(), false, date.isCurrentMonth(), date.isCurrentYear()][views.calendarView];
      List infoList = [
        getDayInfo(dates.selectedDate),
        getWeekInfo(dates.currentWeekDates[0], dates.currentWeekDates[6]),
        getMonthInfo(dates.selectedYear, dates.selectedMonth),
        dates.selectedYear.toString(),
      ];

      return Container(
        padding: partitionPadding(left: true, right: !isSmallPC()),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //
                  // Go to Previous date
                  if (kIsWeb)
                    AppButton(
                      noStyling: true,
                      tooltip: 'Previous',
                      isRound: true,
                      child: AppIcon(Icons.keyboard_arrow_left, size: 18, faded: true),
                      onPressed: () => swipeToNew(direction: 'left'),
                    ),
                  pw(1),
                  //
                  // Date Info
                  Flexible(
                    child: AppButton(
                      // onPressed: () => jumpToDateDialog(),
                      menuItems: [
                        SfCalendar(
                            initialDate: date.dateTime,
                            onSelect: (date) {
                              popWhatsOnTop();
                              jumpToDate(date);
                            })
                      ],
                      tooltip: 'Go to date',
                      noStyling: true,
                      smallVerticalPadding: true,
                      borderRadius: borderRadiusCrazy,
                      child: FittedBox(child: AppText(size: normal, text: infoList[views.calendarView], fontWeight: FontWeight.bold)),
                    ),
                  ),
                  //
                  // Go to Next date
                  pw(1),
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
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Go to today
                  AppButton(
                    onPressed: () async => goToToday(views.calendarView, isToday),
                    tooltip: getDateInfo(getDatePart(date.now)),
                    borderRadius: borderRadiusCrazy,
                    child: AppText(text: 'Today'),
                  ),
                  // Choose view
                  spw(),
                  ViewChooser(),
                  //
                ],
              ),
            ),
            //
          ],
        ),
      );
    });
  }
}
