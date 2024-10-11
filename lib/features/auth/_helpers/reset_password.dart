import 'package:firebase_auth/firebase_auth.dart';

import '../../../_helpers/debug.dart';
import '../../../_helpers/internet_connection.dart';
import '../../../_variables/navigation.dart';
import '../../../_widgets/others/toast.dart';
import 'auth_error_handler.dart';

Future<void> resetPassword({required String email, bool validate = true}) async {
  if (!validate || signInFormKey.currentState!.validate()) {
    if (await noInternet()) return;

    await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((_) {
      showToast(1, 'Check your email for reset link.', smallTopMargin: true);
    }).catchError((e) {
      showToast(0, handleFirebaseAuthError(e, process: 'reset password'), smallTopMargin: true, duration: 5000);
      errorPrint('reset_password', e);
    });
  }
}
