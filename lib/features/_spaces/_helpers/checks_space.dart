import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/debug.dart';
import '../../../_services/hive/get_data.dart';
import '../../../_services/hive/local_storage_service.dart';
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
    return Hive.box('${spaceId}_info').isOpen;
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

bool isSuperAdmin() {
  try {
    return storage('info').get('o', defaultValue: 'none') == liveUser();
  } catch (e) {
    errorPrint('isSuperAdmin', e);
    return false;
  }
}

bool isAdmin() {
  try {
    return ['1', '2'].contains(storage('members').get(liveUser(), defaultValue: '2'));
  } catch (e) {
    errorPrint('isAdmin', e);
    return false;
  }
}

String memberPriviledge(String userId) {
  return storage('members').get(userId, defaultValue: '2');
}
