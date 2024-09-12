import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import '../../../_helpers/_common/global.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_services/firebase/_helpers/helpers.dart';
import '../../../_services/firebase/database.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_variables/navigation.dart';
import '../../../_widgets/others/toast.dart';
import '../../_spaces/_helpers/create_space.dart';
import '../../user/_helpers/set_user_data.dart';
import 'auth_error_handler.dart';

Future<void> signUpUsingEmailPassword({
  required String name,
  required String email,
  required String password,
  required String confirmPassword,
}) async {
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
        //
        //
        if (user != null) {
          // save user data to cloud
          await syncToCloud(db: 'users', parentId: user.uid, type: 'info', action: 'c', data: {'n': name, 'e': email});
          await cloudService.writeData(db: 'default', 'users/${emailAsKey(email)}', user.uid);
          showToast(1, 'Sign up successful...', smallTopMargin: true);

          // we save user data in the local
          await setUserData(user.uid, {'e': email, 'n': name});
          // we create the user's default space
          await createNewSpace(isDefault: true, isNewUser: true);
          // we go to homepage
          navigatorState.currentContext!.replace('/');
        }

        printThis('::::SIGN UP COMPLETE! - $email - ${user?.displayName}');
      } else {
        showToast(0, 'Passwords should match', smallTopMargin: true);
      }
    }
  } on FirebaseAuthException catch (error) {
    //
    showToast(0, handleFirebaseAuthError(error, process: 'sign up'), smallTopMargin: true);
  } catch (error) {
    //
    showToast(0, handleOtherErrors(error, process: 'sign up'), smallTopMargin: true);
  }
}
