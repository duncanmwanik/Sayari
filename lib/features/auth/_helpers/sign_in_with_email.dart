import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import '../../../_helpers/_common/global.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_helpers/user/set_user_data.dart';
import '../../../_variables/navigation.dart';
import '../../../_widgets/others/toast.dart';
import '../_vars/variables.dart';
import 'auth_error_handler.dart';

Future<void> signInUsingEmailPassword({required String email, required String password}) async {
  try {
    hideKeyboard();

    // Validate the Sign In Form Input
    if (signInFormKey.currentState!.validate()) {
      showToast(2, 'Signing you in...');

      FirebaseAuth auth = FirebaseAuth.instance;
      User? user;

      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
      //
      // if user is not null, sign in was successful
      // we save user data locally and go to homepage
      if (user != null) {
        await setUserData(user.uid, user.displayName ?? 'User X', email);
        // we go to homepage
        // TODOs: does not work for mobile
        navigatorState.currentContext!.replace('/');
      }

      printThis('.......................... SIGN IN COMPLETE!');
    }
  } on FirebaseAuthException catch (error) {
    //
    showToast(0, handleFirebaseAuthError(error, process: 'sign in'));
  } catch (error) {
    //
    showToast(0, handleOtherErrors(error, process: 'sign in'));
  }
}
