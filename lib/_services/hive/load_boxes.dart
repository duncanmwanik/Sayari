import 'package:hive_flutter/hive_flutter.dart';

import '../../_variables/features.dart';
import '../../features/_spaces/_helpers/common.dart';
import '../../features/user/_helpers/set_user_data.dart';
import 'local_storage_service.dart';

Future<void> initializeHive() async {
  await Hive.initFlutter();
  await loadAllBoxes();
}

Future<void> loadAllBoxes() async {
  globalBox = await Hive.openBox('global');
  spaceNamesBox = await Hive.openBox('spaceName');
  userEmailsBox = await Hive.openBox('userEmails');
  activityVersionBox = await Hive.openBox('activityVersion');
  pendingBox = await Hive.openBox('pending');
  fileBox = await Hive.openBox('filePaths');
  fileNamesBox = await Hive.openBox('fileNames');
  cachedFileBox = await Hive.openBox('cachedFile');

  await loadUserBoxes(liveUser());
  await loadSelectedSpaceBoxes(liveSpace());
  // important to avoid errors when no space is selected
  await loadSelectedSpaceBoxes('none');
  //
}

Future<void> loadSelectedSpaceBoxes(String spaceId) async {
  await Hive.openBox(spaceId);
  await Hive.openBox('${spaceId}_info');
  await Hive.openBox('${spaceId}_admins');
  await Hive.openBox('${spaceId}_activity');
  await Hive.openBox('${spaceId}_notifications');
  await Hive.openBox('${spaceId}_subtypes');
  await Hive.openBox('${spaceId}_${feature.chat.t}');
  await Hive.openBox('${spaceId}_${feature.calendar.t}');
  await Hive.openBox('${spaceId}_${feature.items.t}');
  await Hive.openBox('${spaceId}_${feature.code.t}');
  await Hive.openBox('${spaceId}_${feature.flags.t}');
  await Hive.openBox('${spaceId}_${feature.labels.t}');
}

Future<void> loadUserBoxes(String userId) async {
  await Hive.openBox(userId);
  await Hive.openBox('${userId}_info');
  userDataBox = await Hive.openBox('${userId}_data');
  settingBox = await Hive.openBox('${userId}_settings');
  savedBox = await Hive.openBox('${userId}_saved');
}
