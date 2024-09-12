import 'package:firebase_auth/firebase_auth.dart';

import '../../../_helpers/_common/global.dart';
import '../../../_helpers/_common/internet_connection.dart';
import '../../../_variables/navigation.dart';
import '../../../_widgets/others/toast.dart';
import 'auth_error_handler.dart';

Future<void> resetPassword({required String email, bool validate = true}) async {
  try {
    if (!validate || signInFormKey.currentState!.validate()) {
      showToast(2, 'Resetting password...', smallTopMargin: true);
      hasAccessToInternet().then((hasIntenet) async {
        if (hasIntenet) {
          await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((_) {
            showToast(1, 'Check your email for reset link.', smallTopMargin: true);
          }).catchError((e) {
            errorPrint('reset_password', e);
            showToast(0, handleFirebaseAuthError(e, process: 'reset password'), smallTopMargin: true);
          });
        }
      });
    }
  } catch (e) {
    errorPrint('reset-password', e);
  }
}
