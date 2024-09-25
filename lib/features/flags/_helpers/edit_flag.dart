import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/_common/global.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_variables/features.dart';
import '../../_spaces/_helpers/common.dart';

Future<void> editFlag(String newFlag, String color, String previousFlag) async {
  try {
    String spaceId = liveSpace();
    Hive.box('${liveSpace()}_${feature.flags}').put(newFlag, color);
    Hive.box('${liveSpace()}_${feature.flags}').delete(previousFlag);

    await syncToCloud(db: 'spaces', parentId: spaceId, type: feature.flags, action: 'd', itemId: previousFlag);
    await syncToCloud(db: 'spaces', parentId: spaceId, type: feature.flags, action: 'c', itemId: newFlag, data: color);
  } catch (e) {
    errorPrint('edit-flag', e);
  }
}
