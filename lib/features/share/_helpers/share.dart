import '../../../_helpers/_common/global.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_variables/features.dart';
import '../../_spaces/_helpers/common.dart';
import '../../user/_helpers/set_user_data.dart';

Future<void> shareItem({
  required String itemId,
  bool update = false,
  bool delete = false,
  String type = '',
  String title = '',
  String tokens = '0',
  String isActive = '1',
  Map updateData = const {},
}) async {
  try {
    // deleting a shared item
    if (delete) {
      await syncToCloud(db: 'shared', parentId: itemId, action: 'd', log: false);
    }
    // updating a shared item
    else if (update) {
      await syncToCloud(
        db: 'shared',
        parentId: itemId,
        action: 'e',
        keys: getJoinedList(updateData.keys.toList()),
        data: updateData,
        log: false,
      );
    }
    // creating a shared item
    else {
      await syncToCloud(
        db: 'shared',
        parentId: itemId,
        action: 'u',
        data: {
          's': liveSpace(),
          'u': liveUser(),
          'n': liveUserName(),
          'y': type,
          't': title,
          feature.share: isActive,
          'c': tokens,
        },
        log: false,
      );
    }
    //
  } catch (e) {
    errorPrint('${update ? 'update' : (delete ? 'delete' : 'create')}-shared-$type-$itemId', e);
  }
}
