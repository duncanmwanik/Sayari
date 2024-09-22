import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/_common/global.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../user/_helpers/set_user_data.dart';
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

Future<bool> isOwner(String spaceId) async {
  try {
    Box box = await Hive.openBox('${spaceId}_info');
    return box.get('o', defaultValue: 'none') == liveUser();
  } catch (e) {
    return false;
  }
}

bool isAdmin() {
  try {
    return Hive.box('${liveSpace()}_admins').containsKey(liveUser());
  } catch (e) {
    errorPrint('isSpaceAdmin', e);
    return false;
  }
}

bool isCodeSpace() {
  return true;
  // return Hive.box('${liveSpace()}_info').get('cd', defaultValue: '0') == '1';
}
