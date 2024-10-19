import '../../../../_helpers/extentions/dateTime.dart';

bool doesCurrentWeekListCodntainToday(List<DateTime> currentWeekDates, DateTime today) {
  bool itContains = false;

  for (DateTime date in currentWeekDates) {
    if (date.part() == today.part()) {
      itContains = true;
      break;
    }
  }

  return itContains;
}
