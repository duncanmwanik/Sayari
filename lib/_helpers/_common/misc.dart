import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../_widgets/others/toast.dart';
import 'global.dart';

Future<void> checkForStoragePermissions() async {
  if (!kIsWeb && await Permission.storage.isDenied) {
    await Permission.storage.request();
  }
}

Future<void> copyToClipboard(String? text, {String? desc, bool toast = true}) async {
  try {
    await Clipboard.setData(ClipboardData(text: text ?? '')).then((value) {
      if (toast) showToast(1, 'Copied ${desc ?? 'link'}.');
    });
  } catch (e) {
    errorPrint('copy-to-clipboard', e);
  }
}

void doNothing() {}
