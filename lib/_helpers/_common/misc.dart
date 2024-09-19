import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> checkForStoragePermissions() async {
  if (!kIsWeb && await Permission.storage.isDenied) {
    await Permission.storage.request();
  }
}

void doNothing() {}
