import '../../_helpers/debug.dart';
import '../../_helpers/helpers.dart';
import '../../_helpers/internet_connection.dart';
import '../../features/_spaces/_helpers/space_names.dart';
import '../hive/local_storage_service.dart';
import 'database.dart';

Future<void> getAllUserDataFromCloud(String userId) async {
  printThis(':::: Getting All user data...');

  showSyncingLoader(true);

  try {
    hasAccessToInternet().then((hasIntenet) async {
      if (hasIntenet) {
        // workspaces
        await cloudService.getData(db: 'users', '$userId/spaces').then((snapshot) async {
          Map userData = snapshot.value != null ? snapshot.value as Map : {};
          if (userData.isNotEmpty) {
            await userSpacesBox.clear();
            await userSpacesBox.putAll(userData);
            await saveSpacesNamesToLocalStorage(userData);
          }
        });
        // groups
        await cloudService.getData(db: 'users', '$userId/groups').then((snapshot) async {
          Map groupData = snapshot.value != null ? snapshot.value as Map : {};
          if (groupData.isNotEmpty) {
            await userGroupsBox.clear();
            await userGroupsBox.putAll(groupData);
            await saveSpacesNamesToLocalStorage(groupData);
          }
        });
        // settings
        await cloudService.getData(db: 'users', '$userId/settings').then((snapshot) async {
          Map settingsData = snapshot.value != null ? snapshot.value as Map : {};
          if (settingsData.isNotEmpty) {
            await settingBox.clear();
            await settingBox.putAll(settingsData);
          }
        });
        // saved
        await cloudService.getData(db: 'users', '$userId/saved').then((snapshot) async {
          Map savedData = snapshot.value != null ? snapshot.value as Map : {};
          if (savedData.isNotEmpty) {
            await savedBox.clear();
            await savedBox.putAll(savedData);
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
