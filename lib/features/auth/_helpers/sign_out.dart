import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import '../../../_variables/navigation.dart';
import '../../../_widgets/abcs/dialogs_sheets/confirmation_dialog.dart';

Future<void> signOutUser() async {
  await showConfirmationDialog(
      title: 'Are you sure you want to sign out?',
      content: 'Like, really really sure?',
      yeslabel: 'Sign Out',
      onAccept: () async {
        await FirebaseAuth.instance.signOut();
        navigatorState.currentContext!.go('/welcome');
      });
}
