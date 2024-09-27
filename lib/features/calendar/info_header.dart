import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/helpers.dart';
import '../../_providers/views.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';
import '_helpers/date_time/date_info.dart';
import '_helpers/date_time/jump_to_date.dart';
import '_helpers/date_time/misc.dart';
import '_helpers/go_to_today.dart';
import '_helpers/prepare.dart';
import '_helpers/swipe.dart';
import '_w/view_chooser.dart';
import 'state/datetime.dart';

class CalendarOptions extends StatelessWidget {
  const CalendarOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<DateTimeProvider, ViewsProvider>(builder: (context, dates, views, child) {
      DateInfo date = DateInfo(dates.selectedDate);
      List infoList = [
        getDayInfo(dates.selectedDate),
        getWeekInfo(dates.currentWeekDates[0], dates.currentWeekDates[6]),
        getMonthInfo(dates.selectedYear, dates.selectedMonth),
        dates.selectedYear.toString(),
      ];
      bool isToday = [date.isToday(), false, date.isCurrentMonth(), date.isCurrentYear()][views.calendarView];
      date.isToday_ = isToday;

      return Row(
        children: [
          //
          Expanded(
            child: Row(
              children: [
                // date info
                Flexible(
                  child: AppButton(
                    onPressed: () => jumpToDateDialog(),
                    menuItems: isPhone() ? null : jumpToDateMenu(initialDate: date.date),
                    tooltip: 'Go to date',
                    noStyling: true,
                    padding: noPadding,
                    hoverColor: transparent,
                    child: AppText(size: extra, text: infoList[views.calendarView], weight: FontWeight.w800),
                  ),
                ),
                // previous date
                mpw(),
                AppButton(
                  tooltip: 'Previous',
                  isSquare: true,
                  child: AppIcon(Icons.keyboard_arrow_left, size: 18, faded: true),
                  onPressed: () => swipeToNew(direction: 'left'),
                ),
                // next date
                spw(),
                AppButton(
                  tooltip: 'Next',
                  isSquare: true,
                  child: AppIcon(Icons.keyboard_arrow_right, size: 18, faded: true),
                  onPressed: () => swipeToNew(direction: 'right'),
                ),
                // go to today
                spw(),
                AppButton(
                  onPressed: () => date.isToday_ ? doNothing() : goToToday(views.calendarView),
                  tooltip: getDateInfo(getDatePart(date.now)),
                  child: AppText(text: 'Today'),
                ),
              ],
            ),
          ),
          spw(),
          // add session
          if (isNotPhone())
            AppButton(
              onPressed: () => prepareSessionCreation(),
              smallLeftPadding: !isTabAndBelow(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppIcon(Icons.add),
                  if (isNotPhone()) spw(),
                  if (isNotPhone()) Flexible(child: AppText(text: 'Create Session', overflow: TextOverflow.ellipsis)),
                ],
              ),
            ),
          if (isNotPhone()) spw(),
          // choose view
          ViewChooser(),
          //
        ],
      );
    });
  }
}
