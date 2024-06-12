import '../../../_helpers/_common/global.dart';
import '../../../_helpers/user/set_user_data.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../_tables/_helpers/common.dart';

Future<void> shareItem({
  required String itemId,
  bool update = false,
  bool delete = false,
  String type = 'pub',
  String tokens = '0',
  String isActive = '1',
  String key = '',
  String value = '',
}) async {
  try {
    //
    //
    if (delete) {
      await syncToCloud(db: 'shared', parentId: itemId, action: 'd', log: false);
    }
    //
    //
    else if (update) {
      await syncToCloud(
        db: 'shared',
        parentId: itemId,
        action: 'e',
        keys: getJoinedList([key, 'u']),
        data: {key: value, 'u': liveUserName()},
        log: false,
      );
    }
    //
    //
    else {
      await syncToCloud(
        db: 'shared',
        parentId: itemId,
        action: 'u',
        data: {
          't': liveTable(),
          'i': liveUser(),
          'u': liveUserName(),
          'y': type,
          'a': isActive,
          'c': tokens,
        },
        log: false,
      );
    }
    //
    //
  } catch (e) {
    errorPrint('${update ? 'update' : (delete ? 'delete' : 'create')}-share-$type-$itemId', e);
  }
}
