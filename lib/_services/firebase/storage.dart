import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../../_helpers/debug.dart';
import '../../_helpers/helpers.dart';
import '../../_widgets/others/toast.dart';
import '../hive/local_storage_service.dart';
import '_helpers/storage_errors.dart';

CloudStorage cloudStorage = CloudStorage();

class CloudStorage {
  final spacesRef = FirebaseStorage.instanceFor(app: Firebase.app(), bucket: 'gs://sayaritables').ref();
  final usersRef = FirebaseStorage.instanceFor(app: Firebase.app(), bucket: 'gs://sayariusers').ref();

  Future<bool> uploadFile({required String db, required String path, required String fileId}) async {
    try {
      if (kIsWeb) {
        (db == 'spaces' ? spacesRef : usersRef).child(path).putData(fileBox.get(fileId)).snapshotEvents.listen(
              (taskSnapshot) => fileProgress(taskSnapshot, db, fileId, 'uploading'),
            );
      } else {
        (db == 'spaces' ? spacesRef : usersRef).child(path).putFile(File(fileBox.get(fileId))).snapshotEvents.listen(
              (taskSnapshot) => fileProgress(taskSnapshot, db, fileId, 'uploading'),
            );
      }
      return true;
    } on FirebaseException catch (e) {
      showToast(0, handleFirebaseStorageError(e, process: 'upload file'));
    } catch (e) {
      errorPrint('upload-file-[$path]', e);
    }
    return false;
  }

  //

  Future<bool> downloadFile(
      {required String db, required String fileName, required String cloudFilePath, required String downloadPath}) async {
    final fileRef = (db == 'spaces' ? spacesRef : usersRef).child(cloudFilePath);

    try {
      if (kIsWeb) {
        // String fileUrl = await fileRef.getDownloadURL();
        // downloadFileOnWeb(fileId, fileUrl);
      }
      //
      else {
        String filePath = '/storage/emulated/0/Sayari/$downloadPath';
        await checkForStoragePermissions();
        final file = File(filePath);
        await file.create(recursive: true);
        final downloadTask = fileRef.writeToFile(file);
        downloadTask.snapshotEvents.listen((taskSnapshot) => fileProgress(taskSnapshot, db, fileName, 'downloading'));
      }
      return true;
    } on FirebaseException catch (e) {
      showToast(0, handleFirebaseStorageError(e, process: 'download file'));
    } catch (e) {
      errorPrint('donload-file', e);
    }
    return false;
  }

  //

  Future<String> getFileUrl({required String db, required String cloudFilePath}) async {
    final fileRef = (db == 'spaces' ? spacesRef : usersRef).child(cloudFilePath);
    String fileUrl = await fileRef.getDownloadURL();
    return fileUrl;
  }

  Future<Uint8List?> getFileBytes({required String db, required String cloudFilePath}) async {
    final fileRef = (db == 'spaces' ? spacesRef : usersRef).child(cloudFilePath);
    Uint8List? bytes = await fileRef.getData();
    return bytes;
  }

  //

  Future<void> deleteFile({required String db, required String path}) async {
    try {
      await (db == 'spaces' ? spacesRef : usersRef).child(path).delete().then((value) => printThis('Deleted file $path'));
    } on FirebaseException catch (e) {
      errorPrint('firebase-delete-file', e);
    } catch (e) {
      errorPrint('delete-file', e);
    }
  }
  //
}

void fileProgress(dynamic taskSnapshot, String db, String fileName, String process) {
  {
    switch (taskSnapshot.state) {
      case TaskState.running:
        // TODOs: Handle this case.
        printThis('....$process $db file: $fileName');
        break;
      case TaskState.paused:
        // TODOs: Handle this case.
        printThis('....paused $process $db file: $fileName');
        break;
      case TaskState.success:
        // TODOs: Handle this case.
        printThis('....done $process $db file: $fileName');
        break;
      case TaskState.canceled:
        // TODOs: Handle this case.
        printThis('....canceled $process $db file: $fileName');
        break;
      case TaskState.error:
        // TODOs: Handle this case.
        printThis('....error $process $db file: $fileName');
        break;
    }
  }
}
