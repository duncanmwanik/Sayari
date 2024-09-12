import '../../../../_services/hive/local_storage_service.dart';
import '../../../_helpers/_common/global.dart';
import '../../../_services/firebase/_helpers/helpers.dart';
import '../../user/_helpers/set_user_data.dart';

Future<String> getSpaceNameFromCloud(String spaceId) async {
  String spaceName = await doesSpaceExist(spaceId);
  if (spaceName != 'none') {
    spaceNamesBox.put(spaceId, spaceName);
    printThis('Gotten space name for $spaceId : $spaceName');
    return spaceName;
  } else {
    return '---';
  }
}

String liveSpace() {
  return globalBox.get('${liveUser()}_currentSpaceId', defaultValue: 'none');
}

String getSpaceName(String spaceId) {
  return spaceNamesBox.get(spaceId, defaultValue: 'No Name');
}

String? getCurrentSpaceName() {
  return spaceNamesBox.get(liveSpace(), defaultValue: null);
}
