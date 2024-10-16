import 'package:firebase_auth/firebase_auth.dart';

import '../../../_helpers/debug.dart';
import '../../../_helpers/internet_connection.dart';
import '../../../_variables/navigation.dart';
import '../../../_widgets/others/toast.dart';
import 'auth_error_handler.dart';

Future<bool> resetPassword({required String email, bool validate = true}) async {
  bool success = false;

  if (!validate || signInFormKey.currentState!.validate()) {
    if (await noInternet()) return success;

    await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((_) {
      success = true;
      showToast(1, 'Check your email for reset link.', smallTopMargin: true);
    }).catchError((e) {
      showToast(0, handleFirebaseAuthError(e, process: 'reset password'), smallTopMargin: true, duration: 5000);
      logError('reset_password', e);
    });
  }

  return success;
}
