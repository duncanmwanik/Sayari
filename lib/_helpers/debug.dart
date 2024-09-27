import 'dart:developer';

import 'package:flutter/foundation.dart';

void errorPrint(String where, var e) {
  if (kDebugMode) debugPrint('APP-ERROR: ($where) ^ $e ^');
}

void printThis(var stuff) {
  if (kDebugMode) log(stuff.toString());
}

void safeRun(Function() operation, {String where = 'app-run', Function()? onError}) {
  try {
    operation();
  } catch (e) {
    errorPrint(where, e);
    if (onError != null) onError();
  }
}
