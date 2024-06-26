import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../_widgets/others/toast.dart';
import '../../features/auth/_helpers/auth_error_handler.dart';
import '../_common/global.dart';
import '../_common/internet_connection.dart';
import '../_common/navigation.dart';
import 'set_user_data.dart';

Future<void> editUserDetails(String userName, String password) async {
  try {
    showToast(2, 'Updating details...');

    bool hasInternet = await hasAccessToInternet();

    if (hasInternet) {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;
      if (user != null) {
        AuthCredential credential = EmailAuthProvider.credential(email: liveEmail(), password: password);
        await user.reauthenticateWithCredential(credential);
        await user.updateDisplayName(userName);
        await Hive.box(liveUser()).putAll({'n': userName});
        showToast(1, 'Success. Updated details.');
      }
    }
  } on FirebaseAuthException catch (e) {
    showToast(0, handleFirebaseAuthError(e, process: 'update details'));
  } catch (e) {
    showToast(0, handleOtherErrors(e, process: 'update details'));
  }
}

Future<void> editUserPassword(String currentPassword, String newPassword, String confirmNewPassword) async {
  try {
    hideKeyboard();

    if (newPassword == confirmNewPassword) {
      if (currentPassword != newPassword) {
        hasAccessToInternet().then((value) async {
          if (value) {
            FirebaseAuth auth = FirebaseAuth.instance;
            User? user;

            UserCredential userCredential = await auth.signInWithEmailAndPassword(
              email: liveEmail(),
              password: currentPassword,
            );
            user = userCredential.user;

            if (user != null) {
              await user.updatePassword(newPassword);
              showToast(1, 'Success. Password updated...');
            }
          }
        });
      } else {
        showToast(2, 'Current password is same as new password');
      }
    } else {
      showToast(0, 'New passwords not matching');
    }
  } catch (e) {
    errorPrint('change-user-password', e);
    showToast(0, 'Could not change password...');
  }
}
