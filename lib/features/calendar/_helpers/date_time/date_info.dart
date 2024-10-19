import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../_helpers/extentions/dateTime.dart';
import '../../../../_providers/_providers.dart';
import '../../_vars/date_time.dart';
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

class DateItem {
  final String date;

  DateItem(this.date) {
    dateTime = DateTime.parse(date);
  }

  late DateTime dateTime;
  DateTime now = DateTime.now();
  bool isToday_ = false;

  int day() => dateTime.day;
  int month() => dateTime.month;
  int year() => dateTime.year;
  String monthString() => monthNamesListShort[dateTime.month - 1];
  String weekday() => weekDaysList[dateTime.weekday == 7 ? 0 : dateTime.weekday].shortName;
  TimeOfDay time() => TimeOfDay.fromDateTime(dateTime);
  String time12() => DateFormat.jm().format(dateTime);
  String time24() => DateFormat.Hm().format(dateTime);

  bool isToday() => date == now.part();
  bool isCurrentMonth() => state.dateTime.selectedMonth == now.month && state.dateTime.selectedYear == now.year;
  bool isCurrentYear() => state.dateTime.selectedYear == now.year;
  bool isWeekend() => [6, 7].contains(dateTime.weekday);
  bool isSelectedMonth(String refDate) => dateTime.month == DateTime.parse(refDate).month;
  bool isFuture() => dateTime.isAfter(now.add(const Duration(days: 1)));
  bool isPast() => dateTime.isBefore(now.subtract(const Duration(days: 1)));
  bool isYesterday() => date == now.subtract(const Duration(days: 1)).part();
  //
  String info() => getDateFull(date);
  String only() => dateTime.part();
}
