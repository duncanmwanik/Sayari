import '../../../_helpers/debug.dart';
import '../../../_services/activity/pending/pending_actions.dart';
import '../../../_services/firebase/_helpers/helpers.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/dialogs/confirmation_dialog.dart';
import '../../../_widgets/others/toast.dart';
import '../../_spaces/_helpers/checks_space.dart';
import '../../_spaces/_helpers/select_space.dart';
import '../../user/_helpers/actions.dart';
import '../../user/_helpers/helpers.dart';
import 'common.dart';

Future<void> deleteSpace({required String spaceId, required String spaceName}) async {
  try {
    //
    // Never delete the default workspace eg. 'My Workspace': has a value of 1
    //
    if (isDefaultSpace(spaceId)) {
      showToast(2, 'Your default workspace cannot be deleted.');
      return;
    }

    await showConfirmationDialog(
      title: 'Delete workspace <b>$spaceName</b>?',
      yeslabel: 'Delete',
      content: 'You will lose all data. The workspace will be removed from other users when they open it the next time.',
      onAccept: () async {
        String userId = liveUser();
        // Check if user is the workspace's owner
        await isSpaceOwnerFirebase(spaceId, userId).then((isSpaceOwner) async {
          if (isSpaceOwner) {
            // delete workspace from cloud
            await syncToCloud(db: 'spaces', space: spaceId, action: 'd');
            // remove workspace from local and cloud user data
            await removeSpaceFromUserSpaceData(userId, spaceId);
            // unselect workspace if it was the app-wide selectesd workspace
            await updateSelectedSpace('none');
            //
          } else {
            // Alert user they don't have the priviledge to delete the workspace
            // *Note this point is not expected to be reached as the buttons to delete
            // the workspace should only be available for workspace owner
            showToast(0, 'Only workspace owner can delete the workspace');
            //
          }
        });
      },
    );
  } catch (e) {
    errorPrint('delete-workspace', e);
    showToast(0, 'Could not delete workspace.');
    await addToPendingActions(db: 'spaces', space: spaceId, parent: 'user', action: 'd', data: {'spaceName': spaceName});
  }
}

Future<void> removeSpace({required String spaceId, required String spaceName}) async {
  try {
    // Removes a workspace from non-workspace owners
    // Confirm for removal
    //
    await showConfirmationDialog(
      title: 'Remove workspace <b>$spaceName</b>?',
      yeslabel: 'Remove',
      content: 'The workspace will be completely removed from all your devices.',
      onAccept: () async {
        // Prevent workspace owners from removing their own spaces, they can only delete them
        // *Not expected to be reached as the remove workspace button should be hidden from workspace owners
        await isSpaceOwnerFirebase(spaceId, liveUser()).then((isSpaceOwner) async {
          if (!isSpaceOwner) {
            // remove workspace from local and cloud user data
            await removeSpaceFromUserSpaceData(liveUser(), spaceId);
            // unselect workspace if it was the app-wide selectesd workspace
            await updateSelectedSpace('none');
            //
          }
          //
          else {
            showToast(0, 'You cannot remove a workspace you created. Delete the workspace instead.');
          }
        });
      },
    );
  } catch (e) {
    errorPrint('remove-workspace', e);
    showToast(0, 'Could not remove workspace');
  }
}

Future<void> removeMissingSpace({required String spaceId}) async {
  try {
    //
    // If the workspace data from the cloud is missing, it has been deleted by it's owner
    // So we remove the workspace form all other users still having the workspace
    //
    String spaceName = spaceNamesBox.get(spaceId, defaultValue: '');
    showToast(2, 'The workspace $spaceName is no longer available.');

    await removeSpaceFromUserSpaceData(liveUser(), spaceId);
    // unselect workspace if it was the app-wide selectesd workspace
    if (spaceId == liveSpace()) await updateSelectedSpace('none');
    //
  } catch (e) {
    errorPrint('delete-missing-workspace', e);
  }
}
