import '../../../_helpers/_common/global.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_helpers/forms/regex_checks.dart';
import '../../../_providers/_providers.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/dialogs/confirmation_dialog.dart';
import '../../../_widgets/dialogs/dialog_select_groups.dart';
import '../../../_widgets/others/snackbar.dart';
import '../../../_widgets/others/toast.dart';
import 'set_user_data.dart';

Future<void> addSpaceToGroup(String spaceId) async {
  try {
    await showSelectGroupsDialog();
    List groupNames = state.input.selectedGroups;

    if (groupNames.isNotEmpty) {
      for (String groupName in groupNames) {
        Map groupSpaces = userDataBox.get(groupName, defaultValue: {});
        groupSpaces[spaceId] = 0;
        userDataBox.put(groupName, groupSpaces);

        syncToCloud(db: 'users', parentId: liveUser(), type: 'data', action: 'c', itemId: groupName, subId: spaceId, data: 0);
      }
    }
  } catch (e) {
    errorPrint('add-space-to-group', e);
  }
}

Future<void> removeSpaceFromGroup(String spaceId, String groupName) async {
  try {
    showSnackBar('Removing space from <b>$groupName</b>...');

    String userId = liveUser();
    Map groupSpaces = userDataBox.get(groupName);
    groupSpaces.remove(spaceId);
    userDataBox.put(groupName, groupSpaces);
    //
    syncToCloud(db: 'users', parentId: userId, type: 'data', action: 'd', itemId: groupName, subId: spaceId);
    //
  } catch (e) {
    errorPrint('remove-space-from-group', e);
  }
}

Future<void> addSpaceToUserData(
  String userId,
  String spaceId,
  List groupList, {
  bool isDefault = false,
}) async {
  try {
    // add space to user spaces data
    syncToCloud(db: 'users', parentId: userId, type: 'data', action: 'c', itemId: spaceId, data: isDefault ? 1 : 0);
    // save default space id to user info
    if (isDefault) syncToCloud(db: 'users', parentId: userId, type: 'info', action: 'c', itemId: 's', data: spaceId);
    // add space to the selected groups
    if (groupList.isNotEmpty) {
      for (String groupName in groupList) {
        // add space to local
        Map groupSpaces = userDataBox.get(groupName, defaultValue: {});
        groupSpaces[spaceId] = 0;
        userDataBox.put(groupName, groupSpaces);

        syncToCloud(db: 'users', parentId: liveUser(), type: 'data', action: 'c', itemId: groupName, subId: spaceId, data: 0);
      }
    }

    //
  } catch (e) {
    errorPrint('add-new-space-to-user-data', e);
  }
}

Future<void> removeSpaceFromUserSpaceData(String userId, String spaceId) async {
  try {
    Map userSpaces = userDataBox.toMap();

    userSpaces.forEach((key, value) async {
      // if it's a space
      if (key.toString().startsWith('space') && key.toString() == spaceId) {
        userDataBox.delete(key);
        syncToCloud(db: 'users', parentId: userId, type: 'data', action: 'd', itemId: spaceId);
      }
      // if it's a group
      else {
        Map groupSpaces = value as Map;
        // making a new map unlinks the map used for the loop(forEach)
        // prevents a null error, trust me nakshow
        Map newGroupSpaces = getNewMapFrom(groupSpaces);
        groupSpaces.forEach((space, value) async {
          if (space.toString() == spaceId) {
            newGroupSpaces.remove(spaceId);
            //
            syncToCloud(db: 'users', parentId: userId, type: 'data', action: 'd', itemId: key, subId: spaceId);
            //
          }
        });
        userDataBox.put(key, newGroupSpaces);
      }
    });

    syncToCloud(db: 'users', parentId: userId, type: 'data', action: 'd', itemId: spaceId);

    //
  } catch (e) {
    errorPrint('remove-space-from-user-data', e);
  }
}

Future<void> createGroup(String groupName) async {
  try {
    if (groupName.isNotEmpty) {
      if (isValidGroupName(groupName)) {
        hideKeyboard();
        popWhatsOnTop();

        // {k:0} allows us to keep the group even if it has no space
        userDataBox.put(groupName, {'k': 0});

        syncToCloud(db: 'users', parentId: liveUser(), type: 'data', action: 'c', itemId: groupName, subId: 'k', data: 0);
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
        userDataBox.delete(groupName);

        syncToCloud(db: 'users', parentId: liveUser(), type: 'data', action: 'd', itemId: groupName);
      },
    );
  } catch (e) {
    errorPrint('delete-group', e);
  }
}
