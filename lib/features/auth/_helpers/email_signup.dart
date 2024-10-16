import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import '../../../_helpers/debug.dart';
import '../../../_helpers/extentions/strings.dart';
import '../../../_helpers/navigation.dart';
import '../../../_services/firebase/database.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_variables/navigation.dart';
import '../../../_widgets/others/toast.dart';
import '../../_spaces/_helpers/create.dart';
import '../../user/_helpers/helpers.dart';
import 'auth_error_handler.dart';

Future<bool> signUpUsingEmailPassword({
  required String name,
  required String email,
  required String password,
  required String confirmPassword,
}) async {
  bool success = false;

  try {
    hideKeyboard();
    // Validate the Sign Up Form Input
    if (signInFormKey.currentState!.validate()) {
      // Check for password equality
      if (password == confirmPassword) {
        FirebaseAuth auth = FirebaseAuth.instance;
        User? user;
        UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
        user = userCredential.user;
        await user!.updateDisplayName(name);
        await user.reload();
        user = auth.currentUser;

        if (user != null) {
          // save user data to cloud
          await syncToCloud(db: 'users', space: user.uid, parent: 'info', action: 'c', data: {'n': name, 'e': email});
          await cloudService.writeData(db: 'emails', 'emails/${email.naked()}', user.uid);
          showToast(1, 'Sign up successful...', smallTopMargin: true);
          // we save user data in the local
          await setUserData(user.uid, {'e': email, 'n': name});
          // we create the user's default space
          await createNewSpace(isDefault: true, isNewUser: true);
          // we go to homepage
          navigatorState.currentContext!.replace('/');
        }
        success = true;
        show('::signUpUsingEmailPassword: $email - ${user?.displayName}');
      } else {
        showToast(0, 'Passwords should match', smallTopMargin: true);
      }
    }
  } on FirebaseAuthException catch (error) {
    showToast(0, handleFirebaseAuthError(error, process: 'sign up'), smallTopMargin: true, duration: 5000);
  } catch (error) {
    showToast(0, handleOtherErrors(error, process: 'sign up'), smallTopMargin: true, duration: 5000);
  }

  return success;
}
