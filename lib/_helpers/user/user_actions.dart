import 'package:hive/hive.dart';

import '../../_providers/providers.dart';
import '../../_services/firebase/sync_to_cloud.dart';
import '../../_widgets/abcs/dialogs_sheets/confirmation_dialog.dart';
import '../../_widgets/abcs/dialogs_sheets/dialog_select_groups.dart';
import '../../_widgets/others/snackbar.dart';
import '../../_widgets/others/toast.dart';
import '../_common/global.dart';
import '../_common/navigation.dart';
import '../forms/regex_checks.dart';
import 'set_user_data.dart';

Future<void> addTableToGroup(String tableId) async {
  try {
    await showSelectGroupsDialog();
    List groupNames = state.input.selectedGroups;

    if (groupNames.isNotEmpty) {
      showSnackBar('Adding table to ${groupNames.length == 1 ? 'group' : 'groups'}...');

      for (String groupName in groupNames) {
        Map groupTables = Hive.box('${liveUser()}_data').get(groupName, defaultValue: {});
        groupTables[tableId] = 0;
        Hive.box('${liveUser()}_data').put(groupName, groupTables);

        syncToCloud(
            db: 'users', parentId: liveUser(), type: 'data', action: 'c', itemId: groupName, subId: tableId, data: 0);
      }
    }
  } catch (e) {
    errorPrint('add-table-to-group', e);
  }
}

Future<void> removeTableFromGroup(String tableId, String groupName) async {
  try {
    showSnackBar('Removing table from <b>$groupName</b>...');

    String userId = liveUser();
    Map groupTables = Hive.box('${userId}_data').get(groupName);
    groupTables.remove(tableId);
    Hive.box('${userId}_data').put(groupName, groupTables);
    //
    syncToCloud(db: 'users', parentId: userId, type: 'data', action: 'd', itemId: groupName, subId: tableId);

    //
  } catch (e) {
    errorPrint('remove-table-from-group', e);
  }
}

Future<void> addTableToUserData(
  String userId,
  String tableId,
  List groupList, {
  bool isDefault = false,
}) async {
  try {
    // add table to user tables data
    syncToCloud(db: 'users', parentId: userId, type: 'data', action: 'c', itemId: tableId, data: isDefault ? 1 : 0);
    // save default table id to user info
    syncToCloud(db: 'users', parentId: userId, type: 'info', action: 'c', itemId: 'd', data: tableId);
    // add table to the selected groups
    if (groupList.isNotEmpty) {
      for (String groupName in groupList) {
        // add table to local
        Map groupTables = Hive.box('${userId}_data').get(groupName, defaultValue: {});
        groupTables[tableId] = 0;
        Hive.box('${userId}_data').put(groupName, groupTables);

        syncToCloud(
            db: 'users', parentId: liveUser(), type: 'data', action: 'c', itemId: groupName, subId: tableId, data: 0);
      }
    }

    //
  } catch (e) {
    errorPrint('add-new-table-to-user-data', e);
  }
}

Future<void> removeTableFromUserTableData(String userId, String tableId) async {
  try {
    Map userTables = Hive.box('${userId}_data').toMap();

    userTables.forEach((key, value) async {
      // if it's a table
      if (key.toString().startsWith('table') && key.toString() == tableId) {
        Hive.box('${userId}_data').delete(key);
        syncToCloud(db: 'users', parentId: userId, type: 'data', action: 'd', itemId: tableId);
      }
      // if it's a group
      else {
        Map groupTables = value as Map;
        // making a new map unlinks the map used for the loop(forEach)
        // prevents a null error, trust me nakshow
        Map newGroupTables = getNewMapFrom(groupTables);
        groupTables.forEach((table, value) async {
          if (table.toString() == tableId) {
            newGroupTables.remove(tableId);
            //
            syncToCloud(db: 'users', parentId: userId, type: 'data', action: 'd', itemId: key, subId: tableId);
            //
          }
        });
        Hive.box('${userId}_data').put(key, newGroupTables);
      }
    });

    syncToCloud(db: 'users', parentId: userId, type: 'data', action: 'd', itemId: tableId);

    //
  } catch (e) {
    errorPrint('remove-table-from-user-data', e);
  }
}

Future<void> createGroup(String groupName) async {
  try {
    if (groupName.isNotEmpty) {
      if (isValidGroupName(groupName)) {
        hideKeyboard();
        popWhatsOnTop();

        // {k:0} allows us to keep the group even if it has no table
        Hive.box('${liveUser()}_data').put(groupName, {'k': 0});

        syncToCloud(
            db: 'users', parentId: liveUser(), type: 'data', action: 'c', itemId: groupName, subId: 'k', data: 0);
        //
      } else {
        showToast(0, 'Enter a valid name');
      }
    } else {
      showToast(0, "Group name can't be empty");
    }
  } catch (e) {
    errorPrint('create-group', e);
  }
}

Future<void> deleteGroup(String groupName) async {
  try {
    await showConfirmationDialog(
      title: 'Delete group: $groupName?',
      yeslabel: 'Delete',
      onAccept: () async {
        showSnackBar('Deleting <b>$groupName</b>...');
        Hive.box('${liveUser()}_data').delete(groupName);

        syncToCloud(db: 'users', parentId: liveUser(), type: 'data', action: 'd', itemId: groupName);
      },
    );
  } catch (e) {
    errorPrint('delete-group', e);
  }
}
