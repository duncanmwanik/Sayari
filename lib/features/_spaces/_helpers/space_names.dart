import '../../../_services/firebase/_helpers/helpers.dart';
import '../../../_services/hive/local_storage_service.dart';

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
        if (spaceName != 'none') spaceNamesBox.put(key, spaceName);
      });
    } else if (!key.toString().startsWith('space')) {
      Map groupSpaces = value as Map;
      groupSpaces.forEach((key, value) async {
        if (key.toString().startsWith('space')) {
          await doesSpaceExist(key).then((spaceName) {
            if (spaceName != 'none') {
              spaceNamesBox.put(key, spaceName);
            }
          });
        }
      });
    }
  });

  return defaultSpace;
}
