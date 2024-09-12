import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/_common/global.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_variables/features.dart';
import '../../_spaces/_helpers/common.dart';

Future<void> deleteFlag(String flag) async {
  try {
    String spaceId = liveSpace();
    Hive.box('${liveSpace()}_${feature.flags.t}').delete(flag);
    await syncToCloud(db: 'spaces', parentId: spaceId, type: feature.flags.t, action: 'd', itemId: flag);
  } catch (e) {
    errorPrint('delete-flag', e);
  }
}
