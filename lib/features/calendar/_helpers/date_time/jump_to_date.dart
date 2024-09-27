import 'package:flutter/material.dart';

import '../../../../_helpers/navigation.dart';
import '../../../../_providers/_providers.dart';
import '../../../../_widgets/dialogs/dialog_select_date.dart';
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

Future<void> jumpToDateDialog() async {
  await showSelectDateDialog(onSelect: (date) {
    closeDialog();
    jumpToDate(date);
  });
}

List<Widget> jumpToDateMenu({String initialDate = ''}) {
  return [
    SfCalendar(
      initialDate: initialDate,
      onSelect: (date) {
        popWhatsOnTop();
        jumpToDate(date);
      },
    ),
  ];
}
