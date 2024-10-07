import '../../../../_services/hive/local_storage_service.dart';
import '../../../_helpers/debug.dart';
import '../../../_helpers/helpers.dart';
import '../../../_services/firebase/_helpers/helpers.dart';
import '../../../_variables/constants.dart';
import '../../../_variables/features.dart';
import '../../user/_helpers/helpers.dart';

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

String liveSpace() => globalBox.get('${liveUser()}_currentSpaceId', defaultValue: 'none');
String liveSpaceTitle({String? id, String? other}) => spaceNamesBox.get(id ?? liveSpace(), defaultValue: other ?? '');

String publishedSpaceLink([bool link = false]) => link
    ? '$sayariDefaultPath/${features[feature.space]!.path}/${minString(liveSpaceTitle())}_${liveSpace()}'
    : '/${features[feature.space]!.path}/${minString(liveSpaceTitle())}_${liveSpace()}';

String publishedSpaceId(String path) {
  try {
    return path.substring(path.length - 26);
  } catch (e) {
    return 'sayari';
  }
}
