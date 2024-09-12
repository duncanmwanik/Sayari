import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

import '../../../_helpers/_common/global.dart';
import '../../../_models/files.dart';
import '../../../_providers/providers.dart';
import '../../../_services/hive/local_storage_service.dart';

Future<void> getFilesToUpload({
  bool multiple = true,
  bool dp = false,
  bool imagesOnly = false,
  bool embed = false,
  bool addToInput = true,
  Function(FileStash stash)? onDone,
}) async {
  FileStash stash = FileStash(data: {}, ids: []);

  // try {
  FilePickerResult? results = await FilePicker.platform.pickFiles(
    allowMultiple: multiple && !dp,
    type: (dp || imagesOnly) ? FileType.custom : FileType.any,
    allowedExtensions: (dp || imagesOnly) ? ['jpg', 'jpeg', 'png'] : null,
  );

  if (results != null) {
    List<PlatformFile> files = results.files;

    if (kIsWeb) {
      for (PlatformFile file in files) {
        if (file.bytes != null) {
          stash.addFile(file.name, file.bytes);
        }
      }
    } else {
      for (PlatformFile file in files) {
        if (file.path != null) {
          stash.addFile(file.name, file.path);
        }
      }
    }

    if (dp) {
      await fileBox.put('dp', stash.data.values.first);
    }
    //
    else {
      String fileId = embed ? 'fe${getUniqueId()}' : 'f${getUniqueId()}';
      stash.addFileId(fileId);
      if (addToInput) state.input.update(action: 'add', key: fileId, value: stash.fileName());
      await fileBox.put(fileId, stash.fileValue());
    }

    if (stash.isValid()) onDone!(stash);
  }
  // } catch (e) {
  //   showToast(2, 'Could not get files.');
  //   errorPrint('get-files-to-upload', e);
  // }
}
