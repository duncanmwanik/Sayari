import 'package:firebase_auth/firebase_auth.dart';

import '../../../_helpers/_common/global.dart';

String handleFirebaseAuthError(FirebaseAuthException e, {String process = 'process'}) {
  String message = e.message ?? '';
  errorPrint('sign-in-firebaseAuth: code: ${e.code}', e);

  if (e.code == 'user-not-found' ||
      e.code == 'invalid-login-credentials' ||
      ['user-not-found', 'The supplied auth credential is incorrect, malformed or has expired.'].contains(message)) {
    return 'No account found for that email.';
  }
  //
  else if (e.code == 'wrong-password' || message.contains('auth/wrong-password')) {
    return 'Wrong password.';
  }
  //
  else if (e.code == 'invalid-email') {
    return 'Email is invalid.';
  }
  //
  else if (e.code == 'user-disabled') {
    return 'Account has been disabled.';
  }
  //
  else if (e.code == 'too-many-requests') {
    return 'Please try again after some time.';
  }
  //
  else if (e.code == 'operation-not-allowed') {
    return 'Could not sign in. Try again later.';
  }
  //
  else if (e.code == 'weak-password') {
    return 'Password is too weak.';
  }
  //
  else if (e.code == 'email-already-in-use') {
    return 'Acccount already exists.';
  }
  //
  else if (e.code == 'invalid-credential') {
    return 'Incorrect email or password.';
  }
  //
  else if (message.startsWith('A network error') || message.contains('auth/network-request-failed')) {
    return 'Check your internet connection.';
  }
  //
  else if (message.startsWith('com.google.firebase.FirebaseException: An internal error has occurred')) {
    return 'Check your internet connection.';
  }
  //
  else {
    return 'Failed to $process. Please try again.';
  }
}

String handleOtherErrors(dynamic error, {String process = 'process'}) {
  String message = error.toString();
  errorPrint(process, message);

  if (message.contains('firebase_database/permission-denied')) {
    return 'Failed to fatech some data.';
  }
  //
  else {
    return 'Could not $process. Please try again.';
  }
}
