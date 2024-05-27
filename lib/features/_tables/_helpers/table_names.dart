import '../../../_services/firebase/_helpers/helpers.dart';
import '../../../_services/hive/local_storage_service.dart';

List getGroupNamesAsList(Map userData) {
  List groupNames = List.generate(userData.keys.length, (index) {
    if (!userData.keys.toList()[index].toString().startsWith('table')) {
      return userData.keys.toList()[index].toString();
    }
  });

  List groupNamesNoNulls = [];

  for (var element in groupNames) {
    if (element != null) {
      groupNamesNoNulls.add(element);
    }
  }

  return groupNamesNoNulls;
}

Future<String> saveTablesNamesToLocalStorage(Map userData) async {
  String defaultTable = '';

  userData.forEach((key, value) async {
    if (key.toString().startsWith('table')) {
      await doesTableExist(key).then((tableName) {
        if (tableName != 'none') {
          tableNamesBox.put(key, tableName);
          // if its default table
          if (value == 1) {
            // print('table value: $value : ${value.runtimeType} : $defaultTable');
            // selectNewTable(defaultTable, isFirstTime: true);
          }
        }
      });
    } else if (!key.toString().startsWith('table')) {
      Map groupTables = value as Map;
      groupTables.forEach((key, value) async {
        if (key.toString().startsWith('table')) {
          await doesTableExist(key).then((tableName) {
            if (tableName != 'none') {
              tableNamesBox.put(key, tableName);
            }
          });
        }
      });
    }
  });

  return defaultTable;
}
