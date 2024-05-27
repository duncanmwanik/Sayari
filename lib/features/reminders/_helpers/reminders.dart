import '../../../_helpers/date_time/date_info.dart';
import '../../../_helpers/date_time/misc.dart';

Map reminderPeriodsMap = {'m': 'minutes', 'h': 'hours', 'd': 'days', 'w': 'weeks'};
Map periodMinutes = {'m': 1, 'h': 60, 'd': 1440, 'w': 10080};

String formatReminder(String reminder) {
  try {
    String date = getDateInfoForReminder(reminder.split(' ')[0]);
    String time = get12HourTimeFrom24HourTime(reminder.split(' ')[1], islonger: true);
    return '$date, $time';
  } catch (e) {
    return '';
  }
}

String reminderDateTime(String date, String time) {
  try {
    String time_ = getTimePartFromTimeOfDay(time);
    return '$date $time_';
  } catch (e) {
    return '';
  }
}

int reminderTimeInMinutes(String reminder) {
  try {
    int number = int.parse(reminder.split('.')[0]);
    int periodMinute = periodMinutes[reminder.split('.')[1]];
    return number * periodMinute;
  } catch (e) {
    return 30;
  }
}

bool isLive(String reminder) {
  try {
    return DateTime.parse(reminder).isBefore(DateTime.now());
  } catch (e) {
    return false;
  }
}
