import '../../_providers/providers.dart';
import '../../_variables/date_time.dart';
import 'misc.dart';

String getDayInfo(String date) {
  try {
    return getDateFull(date);
  } catch (e) {
    return date;
  }
}

String getDayInfoFullNames(String date) {
  try {
    DateTime dateTime = DateTime.parse(date);
    bool isCurrentYear = dateTime.year == DateTime.now().year;
    int number = dateTime.weekday == 7 ? 0 : dateTime.weekday;

    return isCurrentYear
        ? '${weekDaysList[number].name}, ${monthNamesList[dateTime.month - 1]} ${dateTime.day}'
        : '${weekDaysList[number].name}, ${monthNamesList[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year}';
  } catch (e) {
    return date;
  }
}

String getWeekInfo(DateTime startDate, DateTime endDate) {
  bool isSameYear = startDate.year == endDate.year;
  bool isSameMonth = startDate.month == endDate.month;

  if (isSameYear) {
    if (isSameMonth) {
      return '${monthNamesListShort[startDate.month - 1]} ${startDate.year}';
    } else {
      return '${monthNamesListShort[startDate.month - 1]} - ${monthNamesListShort[endDate.month - 1]} ${startDate.year}';
    }
  } else {
    return '${monthNamesListShort[startDate.month - 1]} ${startDate.year} - ${monthNamesListShort[endDate.month - 1]} ${endDate.year}';
  }
}

String getMonthInfo(int year, int month) {
  return '${monthNamesListShort[month - 1]} $year';
}

String getDateInfo(String date) {
  try {
    DateTime dateTime = DateTime.parse(date);
    bool isCurrentYear = dateTime.year == DateTime.now().year;
    int number = dateTime.weekday == 7 ? 0 : dateTime.weekday;

    return isCurrentYear
        ? '${weekDaysList[number].shortName}, ${monthNamesListShort[dateTime.month - 1]} ${dateTime.day}'
        : '${weekDaysList[number].shortName}, ${monthNamesListShort[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year}';
  } catch (e) {
    return date;
  }
}

String getDateInfoForReminder(String date) {
  try {
    DateTime dateTime = DateTime.parse(date);
    bool isCurrentYear = dateTime.year == DateTime.now().year;

    return isCurrentYear
        ? '${monthNamesListShort[dateTime.month - 1]} ${dateTime.day}'
        : '${monthNamesListShort[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year}';
  } catch (e) {
    return date;
  }
}

class DateInfo {
  final String date;

  DateInfo(this.date) {
    dateTime = DateTime.parse(date);
  }

  late DateTime dateTime;
  DateTime now = DateTime.now();
  bool isToday_ = false;

  int day() => dateTime.day;
  int month() => dateTime.month;
  int year() => dateTime.year;

  bool isToday() => dateTime.day == now.day && dateTime.month == now.month && dateTime.year == now.year;
  bool isCurrentMonth() => state.dateTime.selectedMonth == now.month && state.dateTime.selectedYear == now.year;
  bool isCurrentYear() => state.dateTime.selectedYear == now.year;
  bool isSelectedMonth(String refDate) => dateTime.month == DateTime.parse(refDate).month;

  bool isFuture() => dateTime.isAfter(now.add(const Duration(days: 1)));
  bool isPast() => dateTime.isBefore(now.subtract(const Duration(days: 1)));

  String dayString() => dateTime.day.toString();
  String monthString() => monthNamesListShort[dateTime.month - 1];
  String weekday() => weekDaysList[dateTime.weekday == 7 ? 0 : dateTime.weekday].shortName;
}
