import 'package:hive_flutter/hive_flutter.dart';

import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_variables/features.dart';
import '../../_notes/_helpers/quick_edit.dart';
import '../../_spaces/_helpers/common.dart';

Future<void> deleteMessageForUser(String id) async {
  try {
    await Hive.box('${liveSpace()}_${feature.chat.t}').delete(id);
    await pendingBox.delete(id);
    await syncToCloud(db: 'spaces', parentId: liveSpace(), action: 'd', itemId: feature.chat.t, subId: id);
  } catch (e) {
    //
  }
}

Future<void> pinMessage(String id) async {
  await editItemExtras(type: feature.chat.t, itemId: id, key: 'p', value: '1');
}

Future<void> unPinMessage(String id) async {
  await editItemExtras(type: feature.chat.t, itemId: id, key: 'd/p');
}
