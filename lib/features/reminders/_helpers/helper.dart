import '../../../_helpers/_common/global.dart';
import 'reminders.dart';

List getReminderList(String reminderString) {
  try {
    List reminderList = [];
    getSplitList(reminderString).forEach((reminder) {
      String reminderNo = reminder.toString().split('.')[0];
      String reminderPeriod = reminder.toString().split('.')[1];

      reminderList.add('$reminderNo ${reminderPeriodsMap[reminderPeriod]}${reminderNo == '1' ? '' : 's'}');
    });

    return reminderList;
  } catch (e) {
    return [];
  }
}

bool hasReminder(String? reminder) {
  if (reminder != null && reminder.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}
