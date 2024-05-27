import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

import '../../../_helpers/_common/global.dart';
import '../../../_helpers/user/set_user_data.dart';
import '../../../_providers/providers.dart';
import '../../../_services/firebase/firebase_storage.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/others/toast.dart';
import 'helper.dart';

Future<Map> getFilesToUpload({bool allowMultiple = true, bool isDp = false, bool imagesOnly = false}) async {
  Map fileMap = {};

  try {
    FilePickerResult? results = await FilePicker.platform.pickFiles(
      allowMultiple: allowMultiple,
      type: (isDp || imagesOnly) ? FileType.custom : FileType.any,
      allowedExtensions: (isDp || imagesOnly) ? ['jpg', 'jpeg', 'png'] : null,
    );

    if (results != null) {
      List<PlatformFile> files = results.files;

      if (kIsWeb) {
        for (PlatformFile file in files) {
          if (file.bytes != null) {
            fileMap[file.name] = file.bytes;
          }
        }
      } else {
        for (PlatformFile file in files) {
          if (file.path != null) {
            fileMap[file.name] = file.path;
          }
        }
      }

      if (isDp) {
        await fileBox.put('dp', fileMap.entries.first.value);
      }
      //
      else if (!allowMultiple) {
        String fileId = 'f${getUniqueId()}';
        state.input.update(action: 'add', key: fileId, value: fileMap.entries.first.key);
        await fileBox.put(fileId, fileMap.entries.first.value);
        return {'fileId': fileId};
      }
      //
      else {
        fileMap.forEach((filename, fileData) async {
          String fileId = 'f${getUniqueId()}';
          state.input.update(action: 'add', key: fileId, value: filename);
          await fileBox.put(fileId, fileData);
        });
      }
    }
  } catch (e) {
    showToast(2, 'Could not select files.');
    errorPrint('get-files-to-upload', e);
  }

  return {};
}

Future<void> chooseUserDp() async {
  await getFilesToUpload(isDp: true, allowMultiple: false).then((fileMap) async {
    if (fileMap.length == 1) {
      if (isImageFile(fileMap.entries.first.key)) {
        showToast(2, 'Uploading your profile picture...');
        await cloudStorage.uploadFile(db: 'users', path: '${liveUser()}/dp.jpg', fileId: 'dp').then((success) {
          if (success) {
            cachedFileBox.delete('dp');
            showToast(1, 'Your profile picture is ready.');
          }
        });
      } else {
        showToast(0, 'Only <b>jpg</b> files under 2 MB are allowed.');
      }
    }
  });
}

Future<void> handleFilesCloud(String tableId, Map source, {String? items}) async {
  //
  // new items
  //
  if (items == null) {
    source.forEach((key, value) async {
      try {
        if (key.toString().startsWith('f')) {
          if (fileBox.containsKey(key)) {
            printThis(':::UPLOADING file -- $value');
            await cloudStorage.uploadFile(db: 'tables', path: '$tableId/$value', fileId: key);
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
            printThis(':::UPLOADING file -- ${source[item]}');
            cloudStorage.uploadFile(db: 'tables', path: '$tableId/${source[item]}', fileId: item);
            if (kIsWeb) await fileBox.delete(item); // releases memory used to store file bytes
          }
        }
        // delete file
        if (item.toString().startsWith('d/f')) {
          String fileId = item.toString().substring(2);
          if (fileNamesBox.containsKey(fileId)) {
            printThis(':::DELETING file -- ${fileNamesBox.get(fileId)}');
            cloudStorage.deleteFile(db: 'tables', path: '$tableId/${fileNamesBox.get(fileId)}');
          }
        }
      } catch (e) {
        errorPrint('upload-file-edit-[$item]', e);
      }
    });
  }
}

Future<void> handleFilesDeletion(String tableId, Map source) async {
  //
  //
  source.forEach((key, value) async {
    try {
      printThis(':::DELETING file forever -- $value');
      cloudStorage.deleteFile(db: 'tables', path: '$tableId/$value');
    } catch (e) {
      errorPrint('delete-file-forever-[$value]', e);
    }
  });
  //
  //
}
