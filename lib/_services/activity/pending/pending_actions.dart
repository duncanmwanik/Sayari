import 'dart:async';

import '../../../_helpers/_common/global.dart';
import '../../hive/local_storage_service.dart';

Future<void> addToPendingActions({
  required String db,
  required String parentId,
  required String type,
  required String action,
  Map data = const {},
  String itemId = '',
  String subId = '',
  String keys = '',
  String extras = '',
  bool log = true,
  isDefault = false,
}) async {
  String pendingActionId = getUniqueId();

  await pendingBox.put(pendingActionId, {
    'db': db,
    'parentId': parentId,
    'type': type,
    'action': action,
    'data': data,
    'itemId': itemId,
    'subId': subId,
    'keys': keys,
    'extras': extras,
    'log': log,
    'isDefault': isDefault,
  });
  printThis('New pending action: $pendingActionId > $type $action $keys : $itemId');
}

// remove this
bool isPendingItem(String id) {
  try {
    return pendingBox.containsKey(id);
  } catch (e) {
    return false;
  }
}

void removeFromPendingActions(String id) {
  pendingBox.delete(id);
  printThis('Removed pending action: $id');
}
