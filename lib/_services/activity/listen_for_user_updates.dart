import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

import '../../features/user/_helpers/set_user_data.dart';
import '../firebase/database.dart';
import '../firebase/get_user_data.dart';
import '../firebase/sync_from_cloud.dart';
import '../hive/local_storage_service.dart';
import 'activity_helper.dart';

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
