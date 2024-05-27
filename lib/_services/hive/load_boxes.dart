import 'package:hive_flutter/hive_flutter.dart';

import '../../_helpers/user/set_user_data.dart';
import '../../_variables/features.dart';
import '../../features/_tables/_helpers/common.dart';
import 'local_storage_service.dart';

Future<void> initializeHive() async {
  await Hive.initFlutter();
  await loadAllBoxes();
}

Future<void> loadAllBoxes() async {
  globalBox = await Hive.openBox('global');
  settingBox = await Hive.openBox('settings');
  tableNamesBox = await Hive.openBox('tableName');
  userEmailsBox = await Hive.openBox('userEmails');
  activityVersionBox = await Hive.openBox('activityVersion');
  pendingBox = await Hive.openBox('pending');
  fileBox = await Hive.openBox('filePaths');
  cachedFileBox = await Hive.openBox('cachedFiles');
  fileNamesBox = await Hive.openBox('fileNames');

  await loadUserBoxes(liveUser());
  await loadSelectedTableBoxes(liveTable());
  // important to avoid errors when no table is selected
  await loadSelectedTableBoxes('none');
  //
}

Future<void> loadSelectedTableBoxes(String tableId) async {
  await Hive.openBox(tableId);
  await Hive.openBox('${tableId}_info');
  await Hive.openBox('${tableId}_admins');
  await Hive.openBox('${tableId}_activity');
  await Hive.openBox('${tableId}_notifications');
  await Hive.openBox('${tableId}_subtypes');
  await Hive.openBox('${tableId}_${feature.chat.t}');
  await Hive.openBox('${tableId}_${feature.sessions.t}');
  await Hive.openBox('${tableId}_${feature.notes.t}');
  await Hive.openBox('${tableId}_${feature.lists.t}');
  await Hive.openBox('${tableId}_${feature.finances.t}');
  await Hive.openBox('${tableId}_${feature.flags.t}');
  await Hive.openBox('${tableId}_${feature.labels.t}');
  await Hive.openBox('${tableId}_${feature.pomodoro.t}');
}

Future<void> loadUserBoxes(String userId) async {
  await Hive.openBox(userId);
  await Hive.openBox('${userId}_info');
  await Hive.openBox('${userId}_data');
}
