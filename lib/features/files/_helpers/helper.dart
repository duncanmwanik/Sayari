import 'package:flutter/foundation.dart';
import 'package:open_filex/open_filex.dart';

import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/others/toast.dart';

Map getFiles(Map source) {
  Map filesOnlyMap = {...source};

  source.forEach((key, value) {
    if (!key.toString().startsWith('f')) {
      filesOnlyMap.remove(key);
    }
  });

  return filesOnlyMap;
}

bool isImageFile(String fileName) {
  try {
    return ['png', 'jpg', 'jpeg', 'webp', 'jfif'].contains(getfileExtension(fileName));
  } catch (e) {
    return false;
  }
}

String getfileExtension(String fileName) {
  try {
    return fileName.split('.').last;
  } catch (e) {
    return 'FILE';
  }
}

String getfileNameOnly(String fileName) {
  try {
    return fileName.split('.').first;
  } catch (e) {
    return 'FILE';
  }
}

void openFile(String fileId) {
  bool isFileDownloaded = fileBox.containsKey(fileId);
  if (isFileDownloaded && !kIsWeb) {
    try {
      OpenFilex.open(fileBox.get(fileId));
    } catch (e) {
      showToast(0, 'Failed to open file');
    }
  }
}
