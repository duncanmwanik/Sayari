import 'package:hive_flutter/hive_flutter.dart';

import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_variables/features.dart';
import '../../_spaces/_helpers/checks_space.dart';
import '../../_spaces/_helpers/common.dart';

Future<void> deleteMessageForUser(String id) async {
  try {
    await Hive.box('${liveSpace()}_${feature.chat}').delete(id);
    await pendingBox.delete(id);
    if (isAdmin()) await syncToCloud(db: 'spaces', parentId: liveSpace(), type: feature.chat, action: 'd', itemId: id);
  } catch (e) {
    //
  }
}
