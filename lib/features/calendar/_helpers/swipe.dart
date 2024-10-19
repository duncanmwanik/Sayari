import '../../../_helpers/extentions/dateTime.dart';
import '../../../_providers/_providers.dart';
import 'date_time/misc.dart';

Future<void> swipeToNew({bool? isSwipeRight, String direction = 'none', int? view}) async {
  bool isNext = true;

  if (isSwipeRight != null) isNext = !isSwipeRight;
  if (direction != 'none') isNext = direction == 'right';

  switch (view ?? state.views.calendarView) {
    case 0:
      String newDate = isNext
          ? DateTime.parse(state.dateTime.selectedDate).add(Duration(days: 1)).part()
          : DateTime.parse(state.dateTime.selectedDate).subtract(Duration(days: 1)).part();
      state.dateTime.updateSelectedDate(newDate);
      break;
    case 1:
      isNext
          ? state.dateTime.updateCurrentWeekDates(state.dateTime.currentWeekDates[6].add(Duration(days: 1)))
          : state.dateTime.updateCurrentWeekDates(state.dateTime.currentWeekDates[0].subtract(Duration(days: 1)));
      state.dateTime.updateSelectedDate(state.dateTime.currentWeekDates[0].part());

      break;
    case 2:
      state.dateTime.updateSelectedMonth(isNext ? 'inc' : 'dec');
      await state.dateTime.updateMonthDatesMap();
      state.dateTime.updateSelectedDate(state.dateTime.monthDatesMap[0] ?? now().part());

      break;
    case 3:
      state.dateTime.updateSelectedYear(isNext ? state.dateTime.selectedYear + 1 : state.dateTime.selectedYear - 1);
      state.dateTime.updateSelectedDate('${state.dateTime.selectedYear}-01-01');

      break;
  }
}
