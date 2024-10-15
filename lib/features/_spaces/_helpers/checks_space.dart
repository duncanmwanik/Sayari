import 'package:hive_flutter/hive_flutter.dart';

import '../../../_services/hive/local_storage_service.dart';
import '../../../_services/hive/store.dart';
import '../../user/_helpers/helpers.dart';
import 'common.dart';

bool isASpaceSelected() => liveSpace() != 'none';
bool isLiveSpace(String spaceId) => spaceId == liveSpace();
bool isSpaceAlreadyAdded(String spaceId) => userSpacesBox.containsKey(spaceId);
bool isDefaultSpace(String spaceId) => userSpacesBox.get(spaceId, defaultValue: 0) == 1;

Future<String> getSpaceNameFuture(String spaceId) async {
  if (spaceNamesBox.containsKey(spaceId)) {
    return spaceNamesBox.get(spaceId);
  } else {
    String spaceName = await getSpaceNameFromCloud(spaceId);
    return spaceName;
  }
}

bool isSpaceOpened(String spaceId) {
  try {
    return storage('info', space: spaceId).isOpen;
  } catch (e) {
    return false;
  }
}

Future<bool> isOwner([String? spaceId]) async {
  try {
    Box box = await Hive.openBox('${spaceId ?? liveSpace()}_info');
    return box.get('o', defaultValue: 'none') == liveUser();
  } catch (e) {
    return false;
  }
}

bool isSuperAdmin() => ['2'].contains(storage('members').get(liveUser(), defaultValue: '0'));
bool isAdmin() => ['1', '2'].contains(storage('members').get(liveUser(), defaultValue: '0'));
String memberPriviledge(String userId) => storage('members').get(userId, defaultValue: '0');
