import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/_common/global.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_helpers/items/validation.dart';
import '../../../_helpers/user/set_user_data.dart';
import '../../../_helpers/user/user_actions.dart';
import '../../../_providers/providers.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_variables/features.dart';
import 'select_table.dart';

Future<void> createNewTable({bool isNewUser = false, bool isDefault = false}) async {
  //
  // signUpUserId: passed after sign-up to create tehe user's first & default table
  // isDefault will be true at the same time
  //
  try {
    //
    // if from sign-up, we set table input data manually
    if (isNewUser) state.input.setInputData(typ: feature.table.t, dta: {'t': 'My Table'});
    //
    if (validateInput(type: feature.table.t)) {
      // close the create table bottom sheet if not from sign-up
      if (!isNewUser) popWhatsOnTop();
      String userId = liveUser();
      String tableId = 'table_${userId.substring(0, 6)}_${getUniqueId().substring(9)}';
      List groupList = state.input.selectedGroups;
      // set table owner
      state.input.data['o'] = userId;
      // remove empty keys
      state.input.data.removeWhere((key, value) => value.toString().isEmpty);

      // LOCAL
      // add table to user data locally
      // default table cannot be deleted and contains shared data across all other tables
      await Hive.box('${liveUser()}_data').put(tableId, isDefault ? 1 : 0);
      // save table info data locally
      await Hive.openBox('${tableId}_info').then((box) async => await box.putAll(state.input.data));
      // add table creator to table admins list as a super-admin
      // super-admin has a value of '1' (table owner)
      // other admins have a value of '0'
      await Hive.openBox('${tableId}_admins').then((box) async => await box.put(userId, '1'));
      // add table name to table names tracking box
      await tableNamesBox.put(tableId, state.input.data['t']);

      // CLOUD
      // add table to cloud user data
      await addTableToUserData(userId, tableId, groupList, isDefault: isDefault);
      // create table in the cloud
      await syncToCloud(db: 'tables', parentId: tableId, type: 'info', action: 'c', data: state.input.data);
      await syncToCloud(db: 'tables', parentId: tableId, type: 'admins', action: 'c', itemId: userId, data: '1');
      await syncToCloud(db: 'tables', parentId: tableId, type: 'activity', itemId: 'latest', action: 'c', data: '1');
      //

      await selectNewTable(tableId, isFirstTime: isNewUser);
      //
    }
  } catch (e) {
    errorPrint('create-table', e);
  }
}
