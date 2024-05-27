import '../../../_helpers/date_time/misc.dart';
import '../../../_providers/providers.dart';

Future<void> swipeToNew({bool? isSwipeRight, String direction = 'none', int? view}) async {
  bool isNext = true;

  if (isSwipeRight != null) isNext = !isSwipeRight;
  if (direction != 'none') isNext = direction == 'right';

  switch (view ?? state.views.sessionsView) {
    case 0:
      String newDate = isNext ? getDatePart(DateTime.parse(state.dateTime.selectedDate).add(Duration(days: 1))) : getDatePart(DateTime.parse(state.dateTime.selectedDate).subtract(Duration(days: 1)));
      state.dateTime.updateSelectedDate(newDate);
      break;
    case 1:
      isNext
          ? state.dateTime.updateCurrentWeekDates(state.dateTime.currentWeekDates[6].add(Duration(days: 1)))
          : state.dateTime.updateCurrentWeekDates(state.dateTime.currentWeekDates[0].subtract(Duration(days: 1)));
      break;
    case 2:
      state.dateTime.updateSelectedMonth(isNext ? 'inc' : 'dec');
      await state.dateTime.updateMonthDatesMap();
      break;
    case 3:
      state.dateTime.updateSelectedYear(isNext ? state.dateTime.selectedYear + 1 : state.dateTime.selectedYear - 1);
      break;
  }
}

Future<void> goToToday(int view, bool isToday) async {
  if (!isToday) {
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
}
