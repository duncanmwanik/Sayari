import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../_providers/providers.dart';
import '../../_widgets/dialogs/dialog_select_date.dart';
import '../../_widgets/others/sfcalendar.dart';
import '../_common/navigation.dart';
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
  await showSelectDateDialog(
      padding: paddingL('lrb'),
      onSelect: (date) {
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
