import 'package:hive_flutter/hive_flutter.dart';

import '../../_helpers/_common/global.dart';
import '../../_helpers/_common/navigation.dart';
import '../../_helpers/date_time/date_info.dart';
import '../../_helpers/date_time/misc.dart';
import '../../features/_tables/_helpers/common.dart';
import '../hive/local_storage_service.dart';

String getActivityDateTime(String timestamp) {
  try {
    String date = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp)).toString();
    return '${getDayInfo(date.split(' ')[0])} at ${get12HourTimeFrom24HourTime(date.split(' ')[1])}';
  } catch (e) {
    return 'Recently';
  }
}

bool isActivityActedOn(String tableId, String timestamp) {
  try {
    return Hive.box('${tableId}_activity').containsKey(timestamp);
  } catch (e) {
    errorPrint('is-activity-acted-on', e);
    return false;
  }
}

Future<void> deleteActivity(String activityId) async {
  try {
    Hive.box('${liveTable()}_activity').delete(activityId);
    popWhatsOnTop();
  } catch (e) {
    errorPrint('delete-activity-for-user', e);
  }
}

String lastActivity(String subject) {
  return activityVersionBox.get(subject, defaultValue: '');
}
