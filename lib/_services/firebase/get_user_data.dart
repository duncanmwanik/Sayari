import '../../_helpers/_common/global.dart';
import '../../_helpers/_common/internet_connection.dart';
import '../../_helpers/_common/loaders.dart';
import '../../features/_spaces/_helpers/space_names.dart';
import '../hive/local_storage_service.dart';
import 'database.dart';

Future<void> getAllUserDataFromCloud(String userId) async {
  printThis(':::: Getting All user data...');

  showSyncingLoader(true);

  try {
    hasAccessToInternet().then((hasIntenet) async {
      if (hasIntenet) {
        // workspaces and groups
        await cloudService.getData(db: 'users', '$userId/data').then((snapshot) async {
          Map userData = snapshot.value != null ? snapshot.value as Map : {};
          if (userData.isNotEmpty) {
            await userDataBox.clear();
            await userDataBox.putAll(userData);
            await saveSpacesNamesToLocalStorage(userData);
          }
        });
        // settings
        await cloudService.getData(db: 'users', '$userId/settings').then((snapshot) async {
          Map userData = snapshot.value != null ? snapshot.value as Map : {};
          if (userData.isNotEmpty) {
            await settingBox.clear();
            await settingBox.putAll(userData);
          }
        });
        // settings
        await cloudService.getData(db: 'users', '$userId/saved').then((snapshot) async {
          Map userData = snapshot.value != null ? snapshot.value as Map : {};
          if (userData.isNotEmpty) {
            await savedBox.clear();
            await savedBox.putAll(userData);
          }
        });
        // update latest version locally
        await cloudService.getData(db: 'users', '$userId/activity/latest').then((snapshot) async {
          String latestActivityVersion = snapshot.value != null ? snapshot.value as String : '';
          if (latestActivityVersion.isNotEmpty) {
            activityVersionBox.put(userId, latestActivityVersion);
          }
        });
        printThis(':::: Updated all user data...');
      }
    });
  } catch (e) {
    errorPrint('get-all-user-data', e);
  }

  showSyncingLoader(false);
}
