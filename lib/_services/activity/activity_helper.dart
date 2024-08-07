import 'package:hive_flutter/hive_flutter.dart';

import '../../_helpers/_common/global.dart';
import '../../_helpers/_common/navigation.dart';
import '../../features/_tables/_helpers/common.dart';
import '../hive/local_storage_service.dart';

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
