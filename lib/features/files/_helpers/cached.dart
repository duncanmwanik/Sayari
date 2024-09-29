// ignore_for_file: depend_on_referenced_packages, implementation_imports, avoid_web_libraries_in_flutter, duplicate_ignore

import 'package:file/src/interface/file.dart' as cfile;
import 'package:flutter_cache_manager/flutter_cache_manager.dart' as cache;

import '../../../_helpers/debug.dart';
import '../../../_helpers/helpers.dart';
import '../../../_providers/_providers.dart';
import '../../../_services/firebase/storage.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../_spaces/_helpers/common.dart';
import 'helper.dart';

Future<cfile.File?> getCachedFile({
  required String fileId,
  String fileName = '',
  String? db,
  String? cloudFilePath,
}) async {
  if (fileId.isNotEmpty) {
    try {
      String fileUrl = cachedFileBox.get(fileId, defaultValue: '');
      String spaceId = isShare() ? state.share.sharedData['s'] : liveSpace();

      if (fileUrl.isEmpty) {
        fileUrl = await cloudStorage.getFileUrl(
          db: db ?? 'spaces',
          cloudFilePath: cloudFilePath ?? '$spaceId/${getFileNameCloud(fileId, fileName)}',
        );
        if (fileUrl.isNotEmpty) cachedFileBox.put(fileId, fileUrl);
        print(':: Gotten file url: $fileUrl');
      }

      var file = await cache.DefaultCacheManager().getSingleFile(fileUrl);
      return file;
      //
    } catch (e) {
      errorPrint('get-cached-file', e);
    }
  }
  return null;
}
