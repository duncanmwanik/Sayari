import '../../../_helpers/debug.dart';
import '../../../_helpers/forms/regex_checks.dart';
import '../../../_helpers/internet_connection.dart';
import '../../../_helpers/navigation.dart';
import '../../../_services/firebase/_helpers/helpers.dart';
import '../../../_services/firebase/database.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_services/hive/store.dart';
import '../../../_widgets/dialogs/confirmation_dialog.dart';
import '../../../_widgets/others/toast.dart';
import 'common.dart';

Future<void> addMemberToSpace(String email) async {
  try {
    if (email.isNotEmpty) {
      if (isValidEmail(email)) {
        hideKeyboard();
        if (await noInternet()) return;

        await cloudService.doesUserExist(email).then((userId) async {
          if (userId.isNotEmpty) {
            String spaceId = liveSpace();

            await isAlreadyAdmin(spaceId, userId).then((isAlreadyAdmin) async {
              if (!isAlreadyAdmin) {
                userEmailsBox.put(userId, email);
                storage('members', space: spaceId).put(userId, '0');
                await syncToCloud(db: 'spaces', space: spaceId, parent: 'members', action: 'c', id: userId, data: '0');
                closeDialog();
                showToast(1, 'Added new member <b>$email</b>');
              } else {
                showToast(1, 'User is already a member');
              }
            });
          } else {
            showToast(0, 'User does not exist');
          }
        });
      } else {
        showToast(0, 'Enter a valid user email');
      }
    } else {
      showToast(0, 'Enter user email');
    }
  } catch (e) {
    showToast(0, 'Could not add member');
  }
}

Future<void> removeMemberFromSpace(String userId, String userEmail) async {
  try {
    await showConfirmationDialog(
      title: 'Remove member <b>$userEmail</b>?',
      yeslabel: 'Remove',
      onAccept: () async {
        String spaceId = liveSpace();
        await isSpaceOwnerFirebase(spaceId, userId).then((isOwner) async {
          if (!isOwner) {
            storage('members', space: spaceId).delete(userId);
            await syncToCloud(db: 'spaces', space: spaceId, parent: 'members', action: 'd', id: userId);
            showToast(1, 'Removed member <b>$userEmail</b>');
          } else {
            showToast(2, 'Space owner cannot be removed.');
          }
        });
      },
    );
  } catch (e) {
    logError('remove-member', e);
    showToast(0, 'Could not remove member');
  }
}

Future<void> changeMemberPriviledge(String userId, String priviledge) async {
  try {
    String spaceId = liveSpace();
    storage('members', space: spaceId).put(userId, priviledge);
    await syncToCloud(db: 'spaces', space: spaceId, parent: 'members', action: 'e', id: userId, data: priviledge);
  } catch (e) {
    logError('changeMemberPriviledge', e);
  }
}

Future<void> getAdminEmail(String userId) async {
  try {
    String memberEmail = await getUserEmailFromCloud(userId);
    userEmailsBox.put(userId, memberEmail);
  } catch (e) {
    logError('getAdminEmail', e);
  }
}
