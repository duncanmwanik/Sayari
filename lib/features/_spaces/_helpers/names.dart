import '../../../_helpers/debug.dart';
import '../../../_services/firebase/_helpers/helpers.dart';
import '../../../_services/hive/local_storage_service.dart';
import 'common.dart';

Future<String> getSpaceName(String spaceId) async {
  if (spaceNamesBox.containsKey(spaceId)) {
    return spaceNamesBox.get(spaceId);
  } else {
    String spaceName = await getSpaceNameFromCloud(spaceId);
    return spaceName;
  }
}

List getGroupNamesAsList(Map userData) {
  List groupNames = List.generate(userData.keys.length, (index) {
    if (!userData.keys.toList()[index].toString().startsWith('space')) {
      return userData.keys.toList()[index].toString();
    }
  });

  List groupNamesNoNulls = [];

  for (var element in groupNames) {
    if (element != null) {
      groupNamesNoNulls.add(element);
    }
  }

  return groupNamesNoNulls;
}

Future<String> saveSpacesNamesToLocalStorage(Map userData) async {
  String defaultSpace = '';

  userData.forEach((key, value) async {
    if (key.toString().startsWith('space')) {
      await doesSpaceExist(key).then((spaceName) {
        if (spaceName.isNotEmpty) spaceNamesBox.put(key, spaceName);
      });
    } else if (!key.toString().startsWith('space')) {
      Map groupSpaces = value as Map;
      groupSpaces.forEach((key, value) async {
        if (key.toString().startsWith('space')) {
          await doesSpaceExist(key).then((spaceName) {
            if (spaceName.isNotEmpty) {
              spaceNamesBox.put(key, spaceName);
            }
          });
        }
      });
    }
  });

  return defaultSpace;
}

void updateSpaceName({String? space, String? name}) => spaceNamesBox.put(space ?? liveSpace(), name);

Future<String> getSpaceNameFromCloud(String spaceId) async {
  String spaceName = await doesSpaceExist(spaceId);
  if (spaceName.isNotEmpty) {
    spaceNamesBox.put(spaceId, spaceName);
    show('Gotten space name for $spaceId : $spaceName');
    return spaceName;
  } else {
    return 'Untitled';
  }
}
