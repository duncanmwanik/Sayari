import '../../_helpers/debug.dart';
import '../../_helpers/helpers.dart';
import '../../_variables/features.dart';
import '../../features/_spaces/_helpers/common.dart';
import '../../features/_spaces/_helpers/names.dart';
import '../hive/local_storage_service.dart';
import '../hive/store.dart';
import 'database.dart';

Future<void> getAllSpaceData(String spaceId, {bool? isFirstTime}) async {
  showSyncingLoader(true);

  await getSpaceInfo(spaceId);
  await getSpaceNameFromCloud(spaceId);
  await getSpaceMemberData(spaceId);
  await getSpaceData(spaceId, feature.timeline);
  await getSpaceData(spaceId, feature.calendar);
  await getSpaceData(spaceId, feature.notes);
  await getSpaceData(spaceId, feature.tags);
  await getSpaceData(spaceId, feature.flags);
  await getSpaceData(spaceId, feature.subTypes);
  await getSpaceData(spaceId, feature.chat);
  await getSpaceActivityVersion(spaceId);

  showSyncingLoader(false);

  show('::AllSpaceData ${liveSpaceTitle(spaceId: spaceId)}');
}

Future<void> getSpaceInfo(String spaceId) async {
  try {
    await cloudService.getData(db: 'spaces', '$spaceId/info').then((snapshot) async {
      Map data = snapshot.value != null ? snapshot.value as Map : {};
      storage('info', space: spaceId).putAll(data);
      updateSpaceName(space: spaceId, name: data['t']);
    });
  } catch (e) {
    logError('getSpaceInfo', e);
  }
}

Future<void> getSpaceMemberData(String spaceId) async {
  try {
    await cloudService.getData(db: 'spaces', '$spaceId/members').then((snapshot) async {
      Map data = snapshot.value != null ? snapshot.value as Map : {};
      if (data.isNotEmpty) {
        storage('members', space: spaceId).clear();
        storage('members', space: spaceId).putAll(data);
      }
    });
  } catch (e) {
    logError('getSpaceMemberData', e);
  }
}

Future<void> getSpaceActivityVersion(String spaceId) async {
  try {
    await cloudService.getData(db: 'spaces', '$spaceId/activity/0').then((snapshot) {
      if (snapshot.value != null) {
        activityVersionBox.put(spaceId, snapshot.value as String);
      }
    });
  } catch (e) {
    logError('getSpaceActivityVersion', e);
  }
}

Future<void> getSpaceData(String spaceId, String type) async {
  try {
    await cloudService.getData(db: 'spaces', '$spaceId/$type').then((snapshot) async {
      Map data = snapshot.value != null ? snapshot.value as Map : {};
      storage(type, space: spaceId).putAll(data);
    });
  } catch (e) {
    logError('getSpaceData: $spaceId - $type', e);
  }
}
