import '../../../_helpers/date_time/misc.dart';
import '../../../_providers/_providers.dart';

Future<void> goToToday(int view) async {
  DateTime now = DateTime.now();

  if (view == 0) {
    state.dateTime.updateSelectedDate(getDatePart(now));
    // Scrollable.ensureVisible(GlobalObjectKey(TimeOfDay.now().hour).currentContext ?? context, duration: Duration(milliseconds: 500), curve: Curves.easeInOutCubic);
  }
  if (view == 1) {
    state.dateTime.updateCurrentWeekDates(now);
  }
  if (view == 2) {
    state.dateTime.updateSelectedYear(now.year);
    state.dateTime.changeSelectedMonth(now.month);
    await state.dateTime.updateMonthDatesMap();
  }
  if (view == 3) {
    state.dateTime.updateSelectedYear(now.year);
    state.dateTime.changeSelectedMonth(now.month);
    await state.dateTime.updateMonthDatesMap();
  }
}
