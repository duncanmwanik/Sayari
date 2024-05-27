import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/_common/global.dart';
import '../../../_helpers/user/set_user_data.dart';
import '../../../_services/hive/local_storage_service.dart';
import 'common.dart';

bool isATableSelected() {
  return liveTable() != 'none';
}

Future<String> getTableNameFuture(String tableId) async {
  if (tableNamesBox.containsKey(tableId)) {
    return tableNamesBox.get(tableId);
  } else {
    String tableName = await getTableNameFromCloud(tableId);
    return tableName;
  }
}

bool isAdmin() {
  try {
    return Hive.box('${liveTable()}_admins').containsKey(liveUser());
  } catch (e) {
    errorPrint('isTableAdmin', e);
    return false;
  }
}

Future<bool> isOwner(String tableId) async {
  try {
    Box box = await Hive.openBox('${tableId}_info');
    return box.get('o', defaultValue: 'none') == liveUser();
  } catch (e) {
    return false;
  }
}

bool isTableAlreadyAdded(String tableId) {
  return Hive.box('${liveUser()}_data').containsKey(tableId);
}

bool isTableOpened(String tableId) {
  try {
    return Hive.box('${tableId}_info').isOpen;
  } catch (e) {
    return false;
  }
}

bool isDefaultTable(String tableId) {
  return Hive.box('${liveUser()}_data').get(tableId, defaultValue: 0) == 1;
}

bool isLiveTable(String tableId) {
  return tableId == liveTable();
}
