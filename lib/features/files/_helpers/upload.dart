import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

import '../../../_helpers/debug.dart';
import '../../../_helpers/global.dart';
import '../../../_models/files.dart';
import '../../../_providers/_providers.dart';
import '../../../_services/hive/local_storage_service.dart';

Future<void> getFilesToUpload({
  bool allowMultiple = true,
  bool imagesOnly = false,
  bool embed = false,
  bool addToInput = true,
  Function(FileStash stash)? onDone,
}) async {
  FileStash stash = FileStash(data: {}, ids: []);

  try {
    FilePickerResult? results = await FilePicker.platform.pickFiles(
      allowMultiple: allowMultiple,
      type: imagesOnly ? FileType.custom : FileType.any,
      allowedExtensions: imagesOnly ? ['jpg', 'jpeg', 'png', 'webp'] : null,
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

      String fileId = embed ? 'fle${getUniqueId()}' : 'fl${getUniqueId()}';
      stash.addFileId(fileId);
      if (addToInput) state.input.update(fileId, stash.fileName());
      await fileBox.put(fileId, stash.fileValue());

      if (stash.isValid()) onDone!(stash);
    }
  } catch (e) {
    logError('get-files-to-upload', e);
  }
}
