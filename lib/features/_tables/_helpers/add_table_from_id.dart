import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/_common/internet_connection.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_helpers/forms/regex_checks.dart';
import '../../../_helpers/user/set_user_data.dart';
import '../../../_helpers/user/user_actions.dart';
import '../../../_services/firebase/_helpers/helpers.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/others/toast.dart';
import 'checks_table.dart';

Future<void> addTableFromId(String tableId) async {
  try {
    if (tableId.isNotEmpty) {
      if (isValidTableId(tableId)) {
        hideKeyboard();
        showToast(2, 'Adding table...');

        if (!isTableAlreadyAdded(tableId)) {
          hasAccessToInternet().then((hasInternet) async {
            if (hasInternet) {
              await doesTableExist(tableId).then((tableName) async {
                if (tableName != 'none') {
                  await Hive.box('${liveUser()}_data').put(tableId, 0);
                  await tableNamesBox.put(tableId, tableName);

                  await addTableToUserData(liveUser(), tableId, []);
                  showToast(1, 'Added table $tableName');
                } else {
                  showToast(0, 'That table does not exist');
                }
              });
            }
          });
        } else {
          showToast(2, 'Table is already added.');
        }
      } else {
        showToast(0, 'Enter a valid table id');
      }
    } else {
      showToast(0, 'Enter table id');
    }
  } catch (error) {
    showToast(0, 'Could not add table');
  }
}
