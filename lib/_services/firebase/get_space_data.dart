import 'package:hive_flutter/hive_flutter.dart';

import '../../_helpers/debug.dart';
import '../../_helpers/helpers.dart';
import '../../_variables/features.dart';
import '../../features/_spaces/_helpers/common.dart';
import '../hive/local_storage_service.dart';
import 'database.dart';

Future<void> getAllSpaceData(String spaceId, {bool? isFirstTime}) async {
  showSyncingLoader(true);

  await getSpaceInfo(spaceId);
  await getSpaceNameFromCloud(spaceId);
  await getSpaceAdminData(spaceId);
  await getSpaceData(spaceId, feature.notes);
  await getSpaceData(spaceId, feature.labels);
  await getSpaceData(spaceId, feature.flags);
  await getSpaceData(spaceId, feature.subTypes);
  await getSpaceData(spaceId, feature.chat);
  await getSpaceAllSessions(spaceId);
  await getSpaceActivityVersion(spaceId);

  showSyncingLoader(false);

  printThis(':::: Updated all space data for "${liveSpaceTitle(id: spaceId)}"');
}

Future<void> getSpaceInfo(String spaceId) async {
  try {
    await cloudService.getData(db: 'spaces', '$spaceId/info').then((snapshot) async {
      Map spaceInfo = snapshot.value != null ? snapshot.value as Map : {};
      Box box = await Hive.openBox('${spaceId}_info');
      box.putAll(spaceInfo);
      spaceNamesBox.put(spaceId, spaceInfo['t']);
    });
  } catch (e) {
    errorPrint('get-space-info-data', e);
  }
}

Future<void> getSpaceAdminData(String spaceId) async {
  try {
    await cloudService.getData(db: 'spaces', '$spaceId/admins').then((snapshot) async {
      Map spaceAdminData = snapshot.value != null ? snapshot.value as Map : {};
      if (spaceAdminData.isNotEmpty) {
        Box box = await Hive.openBox('${spaceId}_admins');
        await box.clear();
        box.putAll(spaceAdminData);
      }
    });
  } catch (e) {
    errorPrint('get-space-admin-data-from-firebase', e);
  }
}

Future<void> getSpaceAllSessions(String spaceId) async {
  try {
    await cloudService.getData(db: 'spaces', '$spaceId/${feature.calendar}').then((snapshot) async {
      Map spaceSessions = snapshot.value != null ? snapshot.value as Map : {};
      await Hive.openBox('${spaceId}_${feature.calendar}').then((box) {
        spaceSessions.forEach((date, sessions) {
          box.put(date, sessions);
        });
      });
    });
  } catch (e) {
    errorPrint('get-space-sessions-from-firebase', e);
  }
}

Future<void> getSpaceActivityVersion(String spaceId) async {
  try {
    await cloudService.getData(db: 'spaces', '$spaceId/activity/latest').then((snapshot) {
      if (snapshot.value != null) {
        activityVersionBox.put(spaceId, snapshot.value as String);
      }
    });
  } catch (e) {
    errorPrint('get-space-activity-data-from-firebase', e);
  }
}

Future<void> getSpaceData(String spaceId, String type) async {
  try {
    await cloudService.getData(db: 'spaces', '$spaceId/$type').then((snapshot) async {
      Map data = snapshot.value != null ? snapshot.value as Map : {};
      await Hive.openBox('${spaceId}_$type').then((box) {
        box.putAll(data);
      });
    });
  } catch (e) {
    errorPrint('get-space-$type-from-firebase', e);
  }
}
