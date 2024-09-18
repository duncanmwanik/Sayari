import 'package:hive_flutter/hive_flutter.dart';

import '../../_helpers/_common/global.dart';
import '../../_helpers/_common/loaders.dart';
import '../../_variables/features.dart';
import '../../features/_spaces/_helpers/common.dart';
import '../hive/local_storage_service.dart';
import 'database.dart';

Future<void> getAllSpaceData(String spaceId, {bool? isFirstTime}) async {
  showSyncingLoader(true);

  await getSpaceInfo(spaceId);
  await getSpaceNameFromCloud(spaceId);
  await getSpaceAdminData(spaceId);
  await getSpaceData(spaceId, feature.chat.t);
  await getSpaceData(spaceId, feature.code.t);
  await getSpaceAllSessions(spaceId);
  await getSpaceAllNotes(spaceId);
  await getSpaceAllLabels(spaceId);
  await getSpaceAllFlags(spaceId);
  await getSpaceTypes(spaceId);
  await getSpaceActivityVersion(spaceId);

  showSyncingLoader(false);

  printThis(':::: Updated all space data for "${liveSpaceTitle(id: spaceId)}"');
}

Future<void> getSpaceInfo(String spaceId) async {
  try {
    Box box = await Hive.openBox('${spaceId}_info');

    await cloudService.getData(db: 'spaces', '$spaceId/info').then((snapshot) async {
      Map spaceInfo = snapshot.value != null ? snapshot.value as Map : {};
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
        await Hive.openBox('${spaceId}_admins').then((box) async {
          await box.clear();
          box.putAll(spaceAdminData);
        });
      }
    });
  } catch (e) {
    errorPrint('get-space-admin-data-from-firebase', e);
  }
}

Future<void> getSpaceAllSessions(String spaceId) async {
  try {
    await cloudService.getData(db: 'spaces', '$spaceId/${feature.calendar.t}').then((snapshot) async {
      Map spaceSessions = snapshot.value != null ? snapshot.value as Map : {};
      await Hive.openBox('${spaceId}_${feature.calendar.t}').then((box) {
        spaceSessions.forEach((date, sessions) {
          box.put(date, sessions);
        });
      });
    });
  } catch (e) {
    errorPrint('get-space-sessions-from-firebase', e);
  }
}

Future<void> getSpaceAllNotes(String spaceId) async {
  try {
    await cloudService.getData(db: 'spaces', '$spaceId/${feature.items.t}').then((snapshot) async {
      Map spaceNotes = snapshot.value != null ? snapshot.value as Map : {};
      await Hive.openBox('${spaceId}_${feature.items.t}').then((box) {
        box.putAll(spaceNotes);
      });
    });
  } catch (e) {
    errorPrint('get-space-notes-from-firebase', e);
  }
}

Future<void> getSpaceAllLabels(String spaceId) async {
  try {
    await cloudService.getData(db: 'spaces', '$spaceId/${feature.labels.t}').then((snapshot) async {
      Map labelsData = snapshot.value != null ? snapshot.value as Map : {};
      await Hive.openBox('${spaceId}_${feature.labels.t}').then((box) {
        box.putAll(labelsData);
      });
    });
  } catch (e) {
    errorPrint('get-space--labels-from-firebase', e);
  }
}

Future<void> getSpaceAllFlags(String spaceId) async {
  try {
    await cloudService.getData(db: 'spaces', '$spaceId/${feature.flags.t}').then((snapshot) async {
      Map flagsData = snapshot.value != null ? snapshot.value as Map : {};
      await Hive.openBox('${spaceId}_${feature.flags.t}').then((box) {
        box.putAll(flagsData);
      });
    });
  } catch (e) {
    errorPrint('get-space-flags-from-firebase', e);
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

Future<void> getSpaceTypes(String spaceId) async {
  try {
    await cloudService.getData(db: 'spaces', '$spaceId/${feature.subTypes.t}').then((snapshot) async {
      Map data = snapshot.value != null ? snapshot.value as Map : {};
      await Hive.openBox('${spaceId}_${feature.subTypes.t}').then((box) {
        box.putAll(data);
      });
    });
  } catch (e) {
    errorPrint('get-space-flags-from-firebase', e);
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
