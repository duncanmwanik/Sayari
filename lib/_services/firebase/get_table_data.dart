import 'package:hive_flutter/hive_flutter.dart';

import '../../_helpers/_common/global.dart';
import '../../_helpers/_common/loaders.dart';
import '../../_variables/features.dart';
import '../../features/_tables/_helpers/common.dart';
import '../hive/local_storage_service.dart';
import 'firebase_database.dart';

Future<void> getAllTableData(String tableId, {bool? isFirstTime}) async {
  showSyncingLoader(true);

  await getTableInfo(tableId);
  await getTableNameFromCloud(tableId);
  await getTableAdminData(tableId);
  await getTableData(tableId, feature.chat.t);
  await getTableAllSessions(tableId);
  await getTableAllNotes(tableId);
  await getTableAllNotes(tableId);
  await getTableAllLists(tableId);
  await getTableAllPeriods(tableId);
  await getTableAllLabels(tableId);
  await getTableAllFlags(tableId);
  await getTableTypes(tableId);
  await getTablePomodoroData(tableId);
  await getTableActivityVersion(tableId);

  showSyncingLoader(false);

  printThis(':::: Updated ALL TABLE data for "${getTableName(tableId)}"');
}

Future<void> getTableInfo(String tableId) async {
  try {
    Box box = await Hive.openBox('${tableId}_info');

    await cloudService.getData(db: 'tables', '$tableId/info').then((snapshot) async {
      Map tableInfo = snapshot.value != null ? snapshot.value as Map : {};
      box.putAll(tableInfo);
      tableNamesBox.put(tableId, tableInfo['t']);
    });
  } catch (e) {
    errorPrint('get-table-info-data', e);
  }
}

Future<void> getTableAdminData(String tableId) async {
  try {
    await cloudService.getData(db: 'tables', '$tableId/admins').then((snapshot) async {
      Map tableAdminData = snapshot.value != null ? snapshot.value as Map : {};
      if (tableAdminData.isNotEmpty) {
        await Hive.openBox('${tableId}_admins').then((box) async {
          await box.clear();
          box.putAll(tableAdminData);
        });
      }
    });
  } catch (e) {
    errorPrint('get-table-admin-data-from-firebase', e);
  }
}

Future<void> getTableAllSessions(String tableId) async {
  try {
    await cloudService.getData(db: 'tables', '$tableId/${feature.sessions.t}').then((snapshot) async {
      Map tableSessions = snapshot.value != null ? snapshot.value as Map : {};
      await Hive.openBox('${tableId}_${feature.sessions.t}').then((box) {
        tableSessions.forEach((date, sessions) {
          box.put(date, sessions);
        });
      });
    });
  } catch (e) {
    errorPrint('get-table-sessions-from-firebase', e);
  }
}

Future<void> getTableAllNotes(String tableId) async {
  try {
    await cloudService.getData(db: 'tables', '$tableId/${feature.notes.t}').then((snapshot) async {
      Map tableNotes = snapshot.value != null ? snapshot.value as Map : {};
      await Hive.openBox('${tableId}_${feature.notes.t}').then((box) {
        box.putAll(tableNotes);
      });
    });
  } catch (e) {
    errorPrint('get-table-notes-from-firebase', e);
  }
}

Future<void> getTableAllLists(String tableId) async {
  try {
    await cloudService.getData(db: 'tables', '$tableId/${feature.notes.t}').then((snapshot) async {
      Map tableLists = snapshot.value != null ? snapshot.value as Map : {};
      if (tableLists.isNotEmpty) {
        await Hive.openBox('${tableId}_${feature.notes.t}').then((box) {
          box.putAll(tableLists);
        });
      }
    });
  } catch (e) {
    errorPrint('get-table-lists-from-firebase', e);
  }
}

Future<void> getTableAllPeriods(String tableId) async {
  try {
    await cloudService.getData(db: 'tables', '$tableId/${feature.finances.t}').then((snapshot) async {
      Map periodsMap = snapshot.value != null ? snapshot.value as Map : {};
      await Hive.openBox('${tableId}_${feature.finances.t}').then((box) {
        box.putAll(periodsMap);
      });
    });
  } catch (e) {
    errorPrint('get-table-notes-from-firebase', e);
  }
}

Future<void> getTableAllLabels(String tableId) async {
  try {
    await cloudService.getData(db: 'tables', '$tableId/${feature.labels.t}').then((snapshot) async {
      Map labelsData = snapshot.value != null ? snapshot.value as Map : {};
      await Hive.openBox('${tableId}_${feature.labels.t}').then((box) {
        box.putAll(labelsData);
      });
    });
  } catch (e) {
    errorPrint('get-table--labels-from-firebase', e);
  }
}

Future<void> getTableAllFlags(String tableId) async {
  try {
    await cloudService.getData(db: 'tables', '$tableId/${feature.flags.t}').then((snapshot) async {
      Map flagsData = snapshot.value != null ? snapshot.value as Map : {};
      await Hive.openBox('${tableId}_${feature.flags.t}').then((box) {
        box.putAll(flagsData);
      });
    });
  } catch (e) {
    errorPrint('get-table-flags-from-firebase', e);
  }
}

Future<void> getTableData(String tableId, String type) async {
  try {
    await cloudService.getData(db: 'tables', '$tableId/$type').then((snapshot) async {
      Map data = snapshot.value != null ? snapshot.value as Map : {};
      await Hive.openBox('${tableId}_$type').then((box) {
        box.putAll(data);
      });
    });
  } catch (e) {
    errorPrint('get-table-$type-from-firebase', e);
  }
}

Future<void> getTableTypes(String tableId) async {
  try {
    await cloudService.getData(db: 'tables', '$tableId/${feature.subTypes.t}').then((snapshot) async {
      Map data = snapshot.value != null ? snapshot.value as Map : {};
      await Hive.openBox('${tableId}_${feature.subTypes.t}').then((box) {
        box.putAll(data);
      });
    });
  } catch (e) {
    errorPrint('get-table-flags-from-firebase', e);
  }
}

Future<void> getTablePomodoroData(String tableId) async {
  try {
    await cloudService.getData(db: 'tables', '$tableId/${feature.pomodoro.t}').then((snapshot) async {
      Map pomodoroData = snapshot.value != null ? snapshot.value as Map : {};
      Hive.box('${tableId}_${feature.pomodoro.t}').putAll(pomodoroData);
    });
  } catch (e) {
    errorPrint('get-table-pomodoro-from-firebase', e);
  }
}

Future<void> getTableActivityVersion(String tableId) async {
  try {
    await cloudService.getData(db: 'tables', '$tableId/activity/latest').then((snapshot) {
      if (snapshot.value != null) {
        activityVersionBox.put(tableId, snapshot.value as String);
      }
    });
  } catch (e) {
    errorPrint('get-table-activity-data-from-firebase', e);
  }
}
