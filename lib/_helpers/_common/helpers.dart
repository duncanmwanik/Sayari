import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../_providers/_providers.dart';
import '../../_services/hive/local_storage_service.dart';

Future delay(int seconds) async => await Future.delayed(Duration(seconds: seconds));
bool isShare() => state.share.isShare();

// string helpers
String minString(String? title) => title != null ? title.replaceAll(RegExp('[^A-Za-z0-9]'), '_') : 'item';
String capitalFirst(String word) => word.length > 2 ? '${word[0].toUpperCase()}${word.substring(1)}' : word;

void showSyncingLoader(bool show) => globalBox.put('showUpdateLoader', show);

Future<void> checkForStoragePermissions() async {
  if (!kIsWeb && await Permission.storage.isDenied) {
    await Permission.storage.request();
  }
}

void doNothing() {}
