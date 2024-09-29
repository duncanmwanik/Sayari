import 'package:flutter/material.dart';

import '../../../../_providers/_providers.dart';
import '../../../../_widgets/others/sfcalendar.dart';
import 'misc.dart';

Future<void> jumpToDate(DateTime? date) async {
  if (date != null) {
    state.dateTime.updateSelectedDate(getDatePart(date));
    switch (state.views.calendarView) {
      case 0:
        break;
      case 1:
        state.dateTime.updateCurrentWeekDates(date);
        break;
      case 2:
        state.dateTime.updateSelectedYear(date.year);
        state.dateTime.changeSelectedMonth(date.month);
        await state.dateTime.updateMonthDatesMap();
        break;
      default:
    }
  }
}

List<Widget> jumpToDateMenu(Function(DateTime)? onSelect) {
  return [
    SfCalendar(initialDate: state.dateTime.selectedDate, onSelect: onSelect),
  ];
}
