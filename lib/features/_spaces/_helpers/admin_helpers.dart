import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/_common/global.dart';
import '../../../_helpers/_common/internet_connection.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_helpers/forms/regex_checks.dart';
import '../../../_services/firebase/_helpers/helpers.dart';
import '../../../_services/firebase/database.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/dialogs/confirmation_dialog.dart';
import '../../../_widgets/others/toast.dart';
import 'common.dart';

Future<void> addAdminToSpace(String email) async {
  try {
    if (email.isNotEmpty) {
      if (isValidEmail(email)) {
        hideKeyboard();

        hasAccessToInternet().then((value) async {
          if (value) {
            await cloudService.doesUserExist(email).then((userId) async {
              if (userId.isNotEmpty) {
                String spaceId = liveSpace();

                await isAlreadyAdmin(spaceId, userId).then((isAlreadyAdmin) async {
                  if (!isAlreadyAdmin) {
                    userEmailsBox.put(userId, email);
                    Hive.box('${spaceId}_admins').put(userId, '0');

                    await syncToCloud(db: 'spaces', parentId: spaceId, type: 'admins', action: 'c', itemId: userId, data: '0');

                    closeDialog();
                    showToast(1, 'Added new admin <b>$email</b>');
                  } else {
                    showToast(1, 'User is already admin');
                  }
                });
              } else {
                showToast(0, 'User does not exist');
              }
            });
          }
        });
      } else {
        showToast(0, 'Enter a valid user email');
      }
    } else {
      showToast(0, 'Enter user email');
    }
  } catch (e) {
    showToast(0, 'Could not add admin');
  }
}

Future<void> removeAdminFromSpace(BuildContext context, String userId, String userEmail) async {
  try {
    await showConfirmationDialog(
      title: 'Remove admin <b>$userEmail</b>?',
      yeslabel: 'Remove',
      onAccept: () async {
        String spaceId = liveSpace();
        await isSpaceOwnerFirebase(spaceId, userId).then((isOwner) async {
          if (!isOwner) {
            Hive.box('${spaceId}_admins').delete(userId);

            await syncToCloud(db: 'spaces', parentId: spaceId, type: 'admins', action: 'd', itemId: userId);

            showToast(1, 'Removed admin <b>$userEmail</b>');
          } else {
            showToast(2, 'Workspace owner cannot be removed.');
          }
        });
      },
    );
  } catch (e) {
    errorPrint('remove-admin', e);
    showToast(0, 'Could not remove admin');
  }
}

Future<void> getAdminEmail(String userId) async {
  try {
    String adminEmail = await getUserEmailFromCloud(userId);
    userEmailsBox.put(userId, adminEmail);
  } catch (e) {
    errorPrint('get-admin-email-from-cloud', e);
  }
}
