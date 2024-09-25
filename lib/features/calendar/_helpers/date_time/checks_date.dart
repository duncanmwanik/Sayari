import 'misc.dart';

bool doesCurrentWeekListContainToday(List currentWeekDates, DateTime today) {
  bool itContains = false;

  for (var date in currentWeekDates) {
    if (getDatePart(date) == getDatePart(today)) {
      itContains = true;
      break;
    }
  }

  return itContains;
}
