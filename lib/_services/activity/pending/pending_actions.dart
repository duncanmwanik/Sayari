import 'dart:async';

import '../../../_helpers/debug.dart';
import '../../../_helpers/global.dart';
import '../../hive/local_storage_service.dart';

Future<void> addToPendingActions({
  required String db,
  required String space,
  required String parent,
  required String action,
  Map data = const {},
  String id = '',
  String sid = '',
  String keys = '',
  String extras = '',
  bool log = true,
}) async {
  String pendingActionId = getUniqueId();

  await pendingBox.put(pendingActionId, {
    'db': db,
    'space': space,
    'parent': parent,
    'action': action,
    'data': data,
    'id': id,
    'sid': sid,
    'keys': keys,
    'extras': extras,
    'log': log,
  });
  printThis('New pending action: $pendingActionId > $parent $action $keys : $id');
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
