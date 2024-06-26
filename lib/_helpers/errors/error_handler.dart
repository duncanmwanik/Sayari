// ignore_for_file: unused_local_variable

import '../_common/global.dart';

void handleUnhandledExceptions(error, StackTrace stackTrace) {
  String message = error.toString();
  // final code = error.code ?? '-';
  // errorPrint('Unhandled Error: code: $code', error);

  String toastMessage = 'An error occured.';

  if (message.startsWith('[firebase_storage/firebase_storage] Object does not exist at location')) {
    toastMessage = 'File is missing.';
  }
  //
  else if (message.startsWith('com.google.firebase.FirebaseException: An internal error has occurred')) {
    toastMessage = 'Network error. Please check your internet connection.';
  }
  //
  else {}

  // showToast(0, toastMessage);
}

String handleOtherErrors(dynamic error, {String process = 'process'}) {
  String message = error.toString();
  errorPrint(process, message);

  if (message.contains('firebase_database/permission-denied')) {
    return 'Failed to fetch info.';
  }
  //
  else {
    return 'Could not $process. Please try again.';
  }
}
