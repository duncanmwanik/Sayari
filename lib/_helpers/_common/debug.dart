import 'dart:developer';

import 'package:flutter/foundation.dart';

void errorPrint(String where, var e) {
  if (kDebugMode) {
    debugPrint('APP-ERROR: ($where) ^ $e ^');
  }
}

void printThis(var stuff) {
  if (kDebugMode) {
    log(stuff.toString());
  }
}
