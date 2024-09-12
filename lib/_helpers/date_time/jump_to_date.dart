import '../../__styling/spacing.dart';
import '../../_providers/providers.dart';
import '../../_widgets/abcs/dialogs_sheets/dialog_select_date.dart';
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
    actionLabel: 'Jump',
    padding: itemPaddingLarge(left: true, right: true, bottom: true),
  ).then((date) => jumpToDate(DateTime.parse(date.first)));
}
