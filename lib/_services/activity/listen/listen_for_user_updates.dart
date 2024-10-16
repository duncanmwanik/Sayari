import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

import '../../../features/user/_helpers/helpers.dart';
import '../../firebase/database.dart';
import '../../firebase/get_user_data.dart';
import '../../firebase/sync_from_cloud.dart';
import '../../hive/local_storage_service.dart';
import '../activity_helper.dart';

StreamSubscription<DatabaseEvent>? listenForUserUpdates() {
  try {
    String userId = liveUser();

    return cloudService.listen(db: 'users', '$userId/activity/0').listen((event) async {
      String newVersion = event.snapshot.value != null ? event.snapshot.value as String : '';
      String lastVersion = lastActivity(userId);
      // show('from: $lastVersion');

      if (lastVersion.isNotEmpty) {
        if (newVersion != lastVersion) {
          await cloudService.getDataStartAfter(db: 'users', '$userId/activity', lastVersion).then((snapshot) {
            Map newActivites = snapshot.value != null ? snapshot.value as Map : {};

            newActivites.forEach((timestamp, activity) async {
              if (timestamp != '0') await syncFromCloud(userId, timestamp, activity);
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
