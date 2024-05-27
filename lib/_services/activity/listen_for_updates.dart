import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

import '../../_helpers/_common/loaders.dart';
import '../../_helpers/user/set_user_data.dart';
import '../../_widgets/others/toast.dart';
import '../../features/_tables/_helpers/checks_table.dart';
import '../../features/_tables/_helpers/common.dart';
import '../../features/_tables/_helpers/delete_table.dart';
import '../firebase/firebase_database.dart';
import '../firebase/get_table_data.dart';
import '../firebase/get_user_data.dart';
import '../firebase/sync_from_cloud.dart';
import '../hive/local_storage_service.dart';
import 'activity_helper.dart';
import 'variables.dart';

StreamSubscription<DatabaseEvent>? listenForTableUpdates() {
  try {
    String tableId = liveTable();
    if (isATableSelected()) {
      return cloudService.ref('tables').child('$tableId/activity/latest').onValue.listen((event) async {
        if (event.snapshot.value != null) {
          String lastVersion = lastActivity(tableId);
          String newVersion = event.snapshot.value as String;

          if (lastVersion.isNotEmpty) {
            if (newVersion != lastVersion) {
              showSyncingLoader(true);

              await cloudService.getDataStartAfter(db: 'tables', '$tableId/activity', lastVersion).then((snapshot) {
                Map newActivites = snapshot.value != null ? snapshot.value as Map : {};
                // remove the latest-version-key, seing as it is not an activity
                newActivites.remove('latest');
                newActivites.forEach((timestamp, activity) async {
                  if (!isActivityActedOn(tableId, timestamp)) {
                    await syncFromCloud(tableId, timestamp, activity);
                  }
                });
              });
              // update latest version locally
              activityVersionBox.put(tableId, newVersion);

              showSyncingLoader(false);
            }
          } else {
            getAllTableData(tableId);
          }
        } else {
          showToast(0, 'Table is no longer available');
          removeMissingTable(tableId: tableId);
        }
      });
    } else {
      return null;
    }
  } catch (e) {
    showSyncingLoader(false);
    return null;
  }
}

StreamSubscription<DatabaseEvent>? listenForUserUpdates() {
  try {
    String userId = liveUser();

    return cloudService.ref('users').child('$userId/activity/latest').onValue.listen((event) async {
      String newVersion = event.snapshot.value != null ? event.snapshot.value as String : '';
      String lastVersion = lastActivity(userId);

      if (lastVersion.isNotEmpty) {
        if (newVersion != lastVersion) {
          await cloudService.getDataStartAfter(db: 'users', '$userId/activity', lastVersion).then((snapshot) {
            Map newActivites = snapshot.value != null ? snapshot.value as Map : {};
            // remove the latest-version-key, seing as it is not an activity
            newActivites.remove('latest');

            newActivites.forEach((timestamp, activity) async {
              await syncFromCloud(userId, timestamp, activity);
            });
          });
          // update latest version locally
          activityVersionBox.put(userId, newVersion);
        }
      } else {
        getAllUserDataFromCloud(userId);
      }
    });
  } catch (e) {
    return null;
  }
}

void initializeSyncListeners() {
  tableSync = listenForTableUpdates();
  userSync = listenForUserUpdates();
}

Future<void> disposeSyncListeners() async {
  await tableSync?.cancel();
  await userSync?.cancel();
}
