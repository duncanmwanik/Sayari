import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/_common/global.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_variables/features.dart';
import '../../_spaces/_helpers/common.dart';

Future<void> createFlag(String flag, String color) async {
  try {
    String spaceId = liveSpace();
    Hive.box('${liveSpace()}_${feature.flags}').put(flag, color);

    await syncToCloud(db: 'spaces', parentId: spaceId, type: feature.flags, action: 'c', itemId: flag, data: color);
  } catch (e) {
    errorPrint('add-flag', e);
  }
}

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

Future<void> deleteFlag(String flag) async {
  try {
    String spaceId = liveSpace();
    Hive.box('${liveSpace()}_${feature.flags}').delete(flag);
    await syncToCloud(db: 'spaces', parentId: spaceId, type: feature.flags, action: 'd', itemId: flag);
  } catch (e) {
    errorPrint('delete-flag', e);
  }
}

String getFlagColor(String flag) {
  try {
    return Hive.box('${liveSpace()}_${feature.flags}').get(flag, defaultValue: '0');
  } catch (_) {
    return '0';
  }
}
