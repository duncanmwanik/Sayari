import 'package:hive_flutter/hive_flutter.dart';

import '../../_helpers/_common/global.dart';
import '../../_helpers/_common/internet_connection.dart';
import '../../_helpers/_common/loaders.dart';
import '../../features/_tables/_helpers/table_names.dart';
import '../hive/local_storage_service.dart';
import 'firebase_database.dart';

Future<void> getAllUserDataFromCloud(String userId) async {
  printThis(':: Getting All user data...');

  showSyncingLoader(true);

  try {
    hasAccessToInternet().then((hasIntenet) async {
      if (hasIntenet) {
        await cloudService.getData(db: 'users', '$userId/data').then((snapshot) async {
          Map userData = snapshot.value != null ? snapshot.value as Map : {};
          if (userData.isNotEmpty) {
            await Hive.box('${userId}_data').clear();
            await Hive.box('${userId}_data').putAll(userData);
            await saveTablesNamesToLocalStorage(userData);
          }
        });

        // update latest version locally
        await cloudService.getData(db: 'users', '$userId/activity/latest').then((snapshot) async {
          String latestActivityVersion = snapshot.value != null ? snapshot.value as String : '';
          if (latestActivityVersion.isNotEmpty) {
            activityVersionBox.put(userId, latestActivityVersion);
          }
        });
        printThis(':: Gotten All user data...');
      }
    });
  } catch (e) {
    errorPrint('get-all-user-data', e);
  }

  showSyncingLoader(false);
}
