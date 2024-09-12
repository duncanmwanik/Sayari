import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../_helpers/_common/global.dart';
import '../../../_services/firebase/storage.dart';
import '../../../_services/hive/local_storage_service.dart';

Future<void> handleFilesCloud(String spaceId, Map source, {String? items}) async {
  //
  // new items
  //
  if (items == null) {
    source.forEach((key, value) async {
      try {
        if (key.toString().startsWith('f')) {
          if (fileBox.containsKey(key)) {
            await cloudStorage.uploadFile(db: 'spaces', path: '$spaceId/$value', fileId: key);
            if (kIsWeb) await fileBox.delete(key); // releases memory used to store file bytes
          }
        }
      } catch (e) {
        errorPrint('upload-file-new-[$value]', e);
      }
    });
  }
  //
  // editing items
  //
  else {
    getSplitList(items).forEach((item) async {
      try {
        // add new file
        if (item.toString().startsWith('f')) {
          if (fileBox.containsKey(item)) {
            cloudStorage.uploadFile(db: 'spaces', path: '$spaceId/${source[item]}', fileId: item);
            if (kIsWeb) await fileBox.delete(item); // releases memory used to store file bytes
          }
        }
        // delete file
        if (item.toString().startsWith('d/f')) {
          String fileId = item.toString().substring(2);
          if (fileNamesBox.containsKey(fileId)) {
            printThis(':::DELETING file -- ${fileNamesBox.get(fileId)}');
            cloudStorage.deleteFile(db: 'spaces', path: '$spaceId/${fileNamesBox.get(fileId)}');
          }
        }
      } catch (e) {
        errorPrint('upload-file-edit-[$item]', e);
      }
    });
  }
}

Future<void> handleFilesDeletion(String spaceId, Map source) async {
  //
  //
  source.forEach((key, value) async {
    try {
      printThis(':::DELETING file forever -- $value');
      cloudStorage.deleteFile(db: 'spaces', path: '$spaceId/$value');
    } catch (e) {
      errorPrint('delete-file-forever-[$value]', e);
    }
  });
  //
  //
}
