import '../../../_helpers/debug.dart';
import '../../../_helpers/forms/regex_checks.dart';
import '../../../_helpers/navigation.dart';
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
        Map groupSpaces = userGroupsBox.get(groupName, defaultValue: {});
        groupSpaces[spaceId] = 0;
        userGroupsBox.put(groupName, groupSpaces);

        syncToCloud(db: 'users', space: liveUser(), parent: 'groups', action: 'c', id: groupName, sid: spaceId, data: 0);
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
    Map groupSpaces = userGroupsBox.get(groupName);
    groupSpaces.remove(spaceId);
    userGroupsBox.put(groupName, groupSpaces);
    //
    syncToCloud(db: 'users', space: userId, parent: 'groups', action: 'd', id: groupName, sid: spaceId);
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
    // default space cannot be deleted and contains shared data across all other spaces
    await userSpacesBox.put(spaceId, isDefault ? 1 : 0);
    syncToCloud(db: 'users', space: userId, parent: 'spaces', action: 'c', id: spaceId, data: isDefault ? 1 : 0);
    // save default space id to user info
    if (isDefault) syncToCloud(db: 'users', space: userId, parent: 'info', action: 'c', id: 's', data: spaceId);
    // add space to the selected groups
    if (groupList.isNotEmpty) {
      for (String group in groupList) {
        // add space to local
        Map groupSpaces = userGroupsBox.get(group, defaultValue: {});
        groupSpaces[spaceId] = 0;
        userGroupsBox.put(group, groupSpaces);

        syncToCloud(db: 'users', space: liveUser(), parent: 'groups', action: 'c', id: group, sid: spaceId, data: 0);
      }
    }

    //
  } catch (e) {
    errorPrint('add-new-space-to-user-data', e);
  }
}

Future<void> removeSpaceFromUserSpaceData(String userId, String spaceId) async {
  try {
    // remove space from all spaces folder
    if (userSpacesBox.containsKey(spaceId)) {
      userSpacesBox.delete(spaceId);
      syncToCloud(db: 'users', space: userId, parent: 'spaces', action: 'd', id: spaceId);
    }

    // remove space from groups
    Map userGroups = userGroupsBox.toMap();

    userGroups.forEach((group, spaces) async {
      Map groupSpaces = spaces as Map;
      // making a new map unlinks the map used for the loop(forEach)
      // prevents a null error, trust me, si ni mi nakshow
      Map newSpaces = {...groupSpaces};

      if (groupSpaces.containsKey(spaceId)) {
        newSpaces.remove(spaceId);
        syncToCloud(db: 'users', space: userId, parent: 'groups', action: 'd', id: group, sid: spaceId);
      }
      userGroupsBox.put(group, newSpaces);
    });
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
        userGroupsBox.put(groupName, {'k': 0});
        syncToCloud(db: 'users', space: liveUser(), parent: 'groups', action: 'c', id: groupName, sid: 'k', data: 0);
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
        userGroupsBox.delete(groupName);

        syncToCloud(db: 'users', space: liveUser(), parent: 'groups', action: 'd', id: groupName);
      },
    );
  } catch (e) {
    errorPrint('delete-group', e);
  }
}
