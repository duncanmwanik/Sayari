// ignore_for_file: depend_on_referenced_packages, implementation_imports, avoid_web_libraries_in_flutter, duplicate_ignore

import 'dart:io' as io;

import 'package:file/src/interface/file.dart' as cfile;
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';

import '../../../_helpers/debug.dart';
import '../../../_helpers/helpers.dart';
import '../../../_services/firebase/storage.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/others/toast.dart';
import '../../_spaces/_helpers/common.dart';
import 'cached.dart';

Future<void> downloadFile(
    {String fileId = '', String fileName = '', String? db, String? cloudFilePath, String? downloadPath, bool fromCloud = false}) async {
  try {
    showToast(2, 'Downloading $fileName...');
    //
    // local
    //
    if (fileBox.containsKey(fileId) && (kIsWeb || await io.File(fileBox.get(fileId)).exists()) && !fromCloud) {
      print('downloading from local fileBox...');
      if (kIsWeb) {
        var bytes = fileBox.get(fileId);
        await FileSaver.instance.saveFile(name: fileName, bytes: bytes);
      } else {
        await checkForStoragePermissions();
        io.File file = io.File(
          downloadPath != null ? '/storage/emulated/0/Sayari/$fileName' : '/storage/emulated/0/Sayari/${liveSpaceTitle()}/$fileName',
        );
        await file.create(recursive: true);
        var bytes = await io.File(fileBox.get(fileId)).readAsBytes();
        await file.writeAsBytes(bytes);
      }
      showToast(1, 'Downloaded $fileName.');
    }
    //
    // cached
    //
    else if (cachedFileBox.containsKey(fileId) && !fromCloud) {
      print('downloading from cache...');
      cfile.File? cachedFile = await getCachedFile(fileId: fileId, fileName: fileName);
      if (cachedFile != null) {
        var bytes = await cachedFile.readAsBytes();

        if (kIsWeb) {
          await FileSaver.instance.saveFile(name: fileName, bytes: bytes);
        } else {
          await checkForStoragePermissions();
          io.File file = io.File(
            downloadPath != null ? '/storage/emulated/0/Sayari/$fileName' : '/storage/emulated/0/Sayari/${liveSpaceTitle()}/$fileName',
          );
          await file.create(recursive: true);
          await file.writeAsBytes(bytes);
        }

        showToast(1, 'Downloaded $fileName.');
      } else {
        print('Redownloading from cloud...');
        downloadFile(fileId: fileId, fileName: fileName, db: db, cloudFilePath: cloudFilePath, downloadPath: downloadPath, fromCloud: true);
      }
    }
    //
    // cloud
    //
    else {
      print('downloading from cloud...');
      await cloudStorage
          .getFileBytes(
        db: db ?? 'spaces',
        cloudFilePath: cloudFilePath ?? '${liveSpace()}/$fileName',
      )
          .then((bytes) async {
        if (bytes != null) {
          if (kIsWeb) {
            await FileSaver.instance.saveFile(name: fileName, bytes: bytes);
          } else {
            await checkForStoragePermissions();
            io.File file = io.File(
              downloadPath != null
                  ? '/storage/emulated/0/Sayari/$fileName'
                  : '/storage/emulated/0/Sayari/${liveSpaceTitle(other: 'Others')}/$fileName',
            );
            await file.create(recursive: true);
            await file.writeAsBytes(bytes);
          }
          showToast(1, 'Downloaded $fileName.');
        }
      });
    }
    //
  } catch (e) {
    showToast(1, 'Could not download $fileName.');
    logError('download-file', e);
  }
}
