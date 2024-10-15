import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../_helpers/debug.dart';
import '../../../_helpers/global.dart';
import '../../../_services/firebase/storage.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../_spaces/_helpers/common.dart';
import 'helper.dart';

Future<void> handleFilesCloud(String spaceId, Map source, {String? items}) async {
  //
  // new items
  //
  if (items == null) {
    source.forEach((key, value) async {
      try {
        if (key.toString().startsWith('fl')) {
          if (fileBox.containsKey(key)) {
            String fileNameCloud = getFileNameCloud(key, value);
            await cloudStorage.uploadFile(db: 'spaces', path: '$spaceId/$fileNameCloud', fileId: key);
            if (kIsWeb) await fileBox.delete(key); // releases memory used to store file bytes
          }
        }
      } catch (e) {
        logError('upload-file-new-[$value]', e);
      }
    });
  }
  //
  // editing items
  //
  else {
    splitList(items).forEach((item) async {
      try {
        // add new file
        if (item.toString().startsWith('fl')) {
          if (fileBox.containsKey(item)) {
            String fileNameCloud = getFileNameCloud(item, source[item]);
            cloudStorage.uploadFile(db: 'spaces', path: '$spaceId/$fileNameCloud', fileId: item);
            if (kIsWeb) await fileBox.delete(item); // releases memory used to store file bytes
          }
        }
        // delete file
        if (item.toString().startsWith('d/f')) {
          String fileId = item.toString().substring(2);
          String fileNameCloud = getFileNameCloud(fileId, source[fileId]);
          show(':::DELETING file -- ${fileNamesBox.get(fileId)}');
          cloudStorage.deleteFile(db: 'spaces', path: '$spaceId/$fileNameCloud');
        }
      } catch (e) {
        logError('upload-file-edit-[$item]', e);
      }
    });
  }
}

Future<void> handleFilesDeletion(Map fileMap) async {
  //
  fileMap.forEach((key, value) async {
    try {
      show(':::DELETING file forever -- $value');
      String fileNameCloud = getFileNameCloud(key, value);
      cloudStorage.deleteFile(db: 'spaces', path: '${liveSpace()}/$fileNameCloud');
    } catch (e) {
      logError('delete-file-forever-[$key : $value]', e);
    }
  });
  //
}
