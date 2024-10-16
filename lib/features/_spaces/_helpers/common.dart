import 'package:hive_flutter/hive_flutter.dart';

import '../../../../_services/hive/local_storage_service.dart';
import '../../../_helpers/helpers.dart';
import '../../../_services/hive/store.dart';
import '../../../_variables/constants.dart';
import '../../../_variables/features.dart';
import '../../user/_helpers/helpers.dart';

String liveSpace() => globalBox.get('${liveUser()}_currentSpaceId', defaultValue: 'none');
String liveSpaceTitle({String? spaceId, String? defaultValue}) => spaceNamesBox.get(
      spaceId ?? liveSpace(),
      defaultValue: defaultValue ?? '',
    );

bool isASpaceSelected() => liveSpace() != 'none';
bool isLiveSpace(String spaceId) => liveSpace() == spaceId;
bool isDefaultSpace(String spaceId) => userSpacesBox.get(spaceId, defaultValue: 0) == 1;

bool isSuperAdmin() => ['2'].contains(storage('members').get(liveUser(), defaultValue: '0'));
bool isAdmin() => ['1', '2'].contains(storage('members').get(liveUser(), defaultValue: '0'));
String memberPriviledge(String userId) => storage('members').get(userId, defaultValue: '0');

bool isSpaceOpened(String spaceId) {
  try {
    return storage('info', space: spaceId).isOpen;
  } catch (e) {
    return false;
  }
}

Future<bool> isOwner([String? spaceId]) async {
  try {
    Box box = await Hive.openBox('${spaceId ?? liveSpace()}_members');
    return ['2'].contains(box.get(liveUser(), defaultValue: '0'));
  } catch (e) {
    return false;
  }
}

String publishedSpaceLink([bool link = false]) => link
    ? '$sayariDefaultPath/${features[feature.space]!.path}/${minString(liveSpaceTitle())}_${liveSpace()}'
    : '/${features[feature.space]!.path}/${minString(liveSpaceTitle())}_${liveSpace()}';

String publishedSpaceId(String path) {
  try {
    return path.substring(path.length - 26);
  } catch (e) {
    return 'missing';
  }
}
