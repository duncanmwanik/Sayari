import '../../../../_services/hive/local_storage_service.dart';
import '../../../_helpers/_common/global.dart';
import '../../../_helpers/user/set_user_data.dart';
import '../../../_services/firebase/_helpers/helpers.dart';

Future<String> getTableNameFromCloud(String tableId) async {
  String tableName = await doesTableExist(tableId);
  if (tableName != 'none') {
    tableNamesBox.put(tableId, tableName);
    printThis('Gotten table name for $tableId : $tableName');
    return tableName;
  } else {
    return '---';
  }
}

String liveTable() {
  return globalBox.get('${liveUser()}_currentTableId', defaultValue: 'none');
}

String getTableName(String tableId) {
  return tableNamesBox.get(tableId, defaultValue: 'No Name');
}

String? getCurrentTableName() {
  return tableNamesBox.get(liveTable(), defaultValue: null);
}
