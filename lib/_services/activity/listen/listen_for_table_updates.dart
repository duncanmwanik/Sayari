import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

import '../../../_helpers/helpers.dart';
import '../../../features/_spaces/_helpers/checks_space.dart';
import '../../../features/_spaces/_helpers/common.dart';
import '../../../features/_spaces/_helpers/delete_space.dart';
import '../../firebase/database.dart';
import '../../firebase/get_space_data.dart';
import '../../firebase/sync_from_cloud.dart';
import '../../hive/local_storage_service.dart';
import '../activity_helper.dart';

StreamSubscription<DatabaseEvent>? listenForSpaceUpdates() {
  try {
    String spaceId = liveSpace();
    if (isASpaceSelected()) {
      return cloudService.listen(db: 'spaces', '$spaceId/activity/0').listen((event) async {
        if (event.snapshot.value != null) {
          String lastVersion = lastActivity(spaceId);
          String newVersion = event.snapshot.value as String;

          if (lastVersion.isNotEmpty) {
            if (newVersion != lastVersion) {
              showSyncingLoader(true);

              await cloudService.getDataStartAfter(db: 'spaces', '$spaceId/activity', lastVersion).then((snapshot) {
                Map newActivites = snapshot.value != null ? snapshot.value as Map : {};
                newActivites.forEach((timestamp, activity) async {
                  if (!isActivityActedOn(spaceId, timestamp) && timestamp != '0') {
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
