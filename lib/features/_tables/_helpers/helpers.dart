import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/user/set_user_data.dart';
import '../../../_providers/providers.dart';
import '../../../_variables/features.dart';
import '../new_table/table_sheet.dart';

void prepareTableForCreation() {
  state.input.setInputData(typ: feature.table.t);
  showTableBottomSheet(isNewTable: true);
}

void prepareTableForEdit(Map tableData) {
  state.input.setInputData(isNw: false, typ: feature.table.t, dta: tableData);
  showTableBottomSheet(isNewTable: false);
}

List<String> getGroupNames() {
  List<String> groupNames = [];
  Map userTables = Hive.box('${liveUser()}_data').toMap();
  userTables.forEach((key, value) {
    if (!key.startsWith('table')) {
      if (!groupNames.contains(key)) {
        groupNames.add(key);
      }
    }
  });

  return groupNames;
}
