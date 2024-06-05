import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import '../../../_helpers/_common/global.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_helpers/user/set_user_data.dart';
import '../../../_services/firebase/firebase_database.dart';
import '../../../_variables/navigation.dart';
import '../../../_widgets/others/toast.dart';
import '../../_tables/_helpers/select_table.dart';
import '../_vars/variables.dart';
import 'auth_error_handler.dart';

Future<void> signInUsingEmailPassword({required String email, required String password}) async {
  try {
    hideKeyboard();

    // Validate the Sign In Form Input
    if (signInFormKey.currentState!.validate()) {
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
            await selectNewTable(userInfo['d'], isFirstTime: true);
            // we go to homepage
            navigatorState.currentContext!.replace('/');
          }
        });
      }

      printThis('::::SIGN IN COMPLETE! - $email - ${user?.displayName}');
    }
  } on FirebaseAuthException catch (error) {
    showToast(0, handleFirebaseAuthError(error, process: 'sign in'), smallTopMargin: true);
  } catch (error) {
    showToast(0, handleOtherErrors(error, process: 'sign in'), smallTopMargin: true);
  }
}
