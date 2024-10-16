import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import '../../../_helpers/debug.dart';
import '../../../_helpers/navigation.dart';
import '../../../_services/firebase/database.dart';
import '../../../_variables/navigation.dart';
import '../../../_widgets/others/toast.dart';
import '../../_spaces/_helpers/select.dart';
import '../../user/_helpers/helpers.dart';
import 'auth_error_handler.dart';

Future<bool> signInUsingEmailPassword({
  required String email,
  required String password,
  bool validate = true,
}) async {
  bool success = false;

  try {
    hideKeyboard();

    // Validate the Sign In Form Input
    if (!validate || signInFormKey.currentState!.validate()) {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user;
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
      // if user is not null, sign in was successful
      if (user != null) {
        // update latest version locally
        await cloudService.getData(db: 'users', '${user.uid}/info').then((snapshot) async {
          Map userInfo = snapshot.value != null ? snapshot.value as Map : {};
          if (userInfo.isNotEmpty) {
            await setUserData(user!.uid, userInfo);
            await selectNewSpace(userInfo['s'], pop: false);
            // we go to homepage
            navigatorState.currentContext!.replace('/');
          }
        });
      }

      success = true;
      show('::signInUsingEmailPassword: $email - ${user?.displayName}');
    }
  } on FirebaseAuthException catch (error) {
    showToast(0, handleFirebaseAuthError(error, process: 'sign in'), smallTopMargin: true, duration: 5000);
  } catch (error) {
    showToast(0, handleOtherErrors(error, process: 'sign in'), smallTopMargin: true, duration: 5000);
  }

  return success;
}
