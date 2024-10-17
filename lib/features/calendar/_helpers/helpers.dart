import '../../../_helpers/global.dart';
import '../../../_models/item.dart';
import '../../../_services/hive/store.dart';
import '../../../_variables/features.dart';

Map getHourMap(Map source, int hour) {
  source.removeWhere((key, value) => value['s'].toString().split(':')[0] != hour.toString());
  return source;
}

void removeDuplicateReminders(Item item) {
  if (item.parent.isCalendar() && item.hasReminder()) {
    item.data['r'] = joinList(splitList(item.reminder()).toSet().toList());
  }
}

bool hasSessions(String date) {
  return (storage(feature.calendar).get(date, defaultValue: {}) as Map).isNotEmpty;
}
