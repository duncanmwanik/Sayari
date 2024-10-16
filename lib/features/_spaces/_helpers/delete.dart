import '../../../_helpers/debug.dart';
import '../../../_services/activity/pending/pending_actions.dart';
import '../../../_services/firebase/_helpers/helpers.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/dialogs/confirmation_dialog.dart';
import '../../../_widgets/others/toast.dart';
import '../../user/_helpers/actions.dart';
import '../../user/_helpers/helpers.dart';
import 'common.dart';
import 'select.dart';

Future<void> deleteSpace({required String spaceId, required String spaceName}) async {
  try {
    //  the default space can't be deleted eg. 'My Space': has a value of 1
    if (isDefaultSpace(spaceId)) {
      showToast(2, 'Your default space cannot be deleted.');
    } else {
      await showConfirmationDialog(
        title: 'Delete space <b>$spaceName</b>?',
        yeslabel: 'Delete',
        content: 'You will lose all data. Members will lose the space when they open it the next time.',
        onAccept: () async {
          // Check if user is the space's owner
          await isSpaceOwnerCloud(spaceId, liveUser()).then((isSpaceOwner) async {
            if (isSpaceOwner) {
              // delete space from cloud
              await syncToCloud(db: 'spaces', space: spaceId, action: 'd');
              // remove space from local and cloud user data
              await removeSpaceForUser(liveUser(), spaceId);
              // unselect space if it was the app-wide selected space
              if (isLiveSpace(spaceId)) await updateSelectedSpace('none');
            } else {
              showToast(0, 'Only space owners can delete the space.');
            }
          });
        },
      );
    }
  } catch (e) {
    logError('deleteSpace', e);
    showToast(0, 'Could not delete space.');
    await addToPendingActions(db: 'spaces', space: spaceId, parent: 'user', action: 'd', data: {'spaceName': spaceName});
  }
}

Future<void> removeSpace({required String spaceId, required String spaceName}) async {
  try {
    // Removes a space from non - space owners
    // Confirm for removal
    await showConfirmationDialog(
      title: 'Remove space <b>$spaceName</b>?',
      yeslabel: 'Remove',
      content: 'The space will be completely removed from all your devices.',
      onAccept: () async {
        // Prevent space owners from removing their own spaces, they can only delete them
        // *Not expected to be reached as the remove space button should be hidden from space owners
        await isSpaceOwnerCloud(spaceId, liveUser()).then((isSpaceOwner) async {
          if (!isSpaceOwner) {
            // remove space from local and cloud user data
            await removeSpaceForUser(liveUser(), spaceId);
            // unselect space if it was the app-wide selectesd space
            await updateSelectedSpace('none');
          } else {
            showToast(0, 'You cannot remove a space you created. Delete the space instead.');
          }
        });
      },
    );
  } catch (e) {
    logError('removeSpace', e);
    showToast(0, 'Could not remove space');
  }
}

Future<void> removeMissingSpace({required String spaceId}) async {
  try {
    // If the space data from the cloud is missing, it has been deleted by it's owner
    // So we remove the space form all other users still having the space
    String spaceName = spaceNamesBox.get(spaceId, defaultValue: '');
    showToast(2, 'The space $spaceName is no longer available.');
    await removeSpaceForUser(liveUser(), spaceId);
    // unselect space if it was the app-wide selected space
    if (isLiveSpace(spaceId)) await updateSelectedSpace('none');
    //
  } catch (e) {
    logError('removeMissingSpace', e);
  }
}
