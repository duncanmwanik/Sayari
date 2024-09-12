import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

import '../../_helpers/_common/loaders.dart';
import '../../features/_spaces/_helpers/checks_space.dart';
import '../../features/_spaces/_helpers/common.dart';
import '../../features/_spaces/_helpers/delete_space.dart';
import '../../features/user/_helpers/set_user_data.dart';
import '../firebase/database.dart';
import '../firebase/get_space_data.dart';
import '../firebase/get_user_data.dart';
import '../firebase/sync_from_cloud.dart';
import '../hive/local_storage_service.dart';
import 'activity_helper.dart';
import 'variables.dart';

StreamSubscription<DatabaseEvent>? listenForSpaceUpdates() {
  try {
    String spaceId = liveSpace();
    if (isASpaceSelected()) {
      return cloudService.ref('spaces').child('$spaceId/activity/latest').onValue.listen((event) async {
        // printThis(event.snapshot.value);

        if (event.snapshot.value != null) {
          String lastVersion = lastActivity(spaceId);
          String newVersion = event.snapshot.value as String;

          if (lastVersion.isNotEmpty) {
            if (newVersion != lastVersion) {
              showSyncingLoader(true);

              await cloudService.getDataStartAfter(db: 'spaces', '$spaceId/activity', lastVersion).then((snapshot) {
                Map newActivites = snapshot.value != null ? snapshot.value as Map : {};
                // remove the latest-version-key, seing as it is not an activity
                newActivites.remove('latest');
                newActivites.forEach((timestamp, activity) async {
                  if (!isActivityActedOn(spaceId, timestamp)) {
                    await syncFromCloud(spaceId, timestamp, activity);
                  }
                });
              });
              // update latest version locally
              activityVersionBox.put(spaceId, newVersion);

              showSyncingLoader(false);
            }
          } else {
            getAllSpaceData(spaceId);
          }
        } else {
          removeMissingSpace(spaceId: spaceId);
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
  spaceSync = listenForSpaceUpdates();
  userSync = listenForUserUpdates();
}

Future<void> disposeSyncListeners() async {
  try {
    await spaceSync?.cancel();
    await userSync?.cancel();
  } catch (e) {
    //
  }
}
