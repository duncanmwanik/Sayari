import '../../../_helpers/debug.dart';
import '../../../_services/firebase/storage.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../files/_helpers/helper.dart';
import '../../files/_helpers/upload.dart';
import 'helpers.dart';

Future<void> chooseUserDp() async {
  try {
    await getFilesToUpload(
      allowMultiple: false,
      imagesOnly: true,
      onDone: (stash) async {
        if (hasUserDp()) removeUserDp();
        String dp = getFileNameCloud(stash.ids.first, stash.data.keys.first);
        userInfoBox.put('p', dp);
        await syncToCloud(db: 'users', space: liveUser(), parent: 'info', action: 'c', id: 'p', data: dp);
        await cloudStorage.uploadFile(db: 'users', path: '${liveUser()}/$dp', fileId: stash.ids.first);
      },
    );
  } catch (e) {
    errorPrint('chooseUserDp', e);
  }
}

void removeUserDp() {
  try {
    String dp = userDp();
    userInfoBox.delete('p');
    syncToCloud(db: 'users', space: liveUser(), parent: 'info', action: 'd', id: 'p');
    cloudStorage.deleteFile(db: 'users', path: '${liveUser()}/$dp');
  } catch (e) {
    errorPrint('removeUserDp', e);
  }
}
