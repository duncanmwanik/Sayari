import '../../../_helpers/debug.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/store.dart';
import '../../../_variables/features.dart';
import '../../_spaces/_helpers/common.dart';

Future<void> editFlag(String newFlag, String color, String previousFlag) async {
  try {
    String spaceId = liveSpace();
    storage(feature.flags).put(newFlag, color);
    storage(feature.flags).delete(previousFlag);

    await syncToCloud(db: 'spaces', space: spaceId, parent: feature.flags, action: 'd', id: previousFlag);
    await syncToCloud(db: 'spaces', space: spaceId, parent: feature.flags, action: 'c', id: newFlag, data: color);
  } catch (e) {
    logError('edit-flag', e);
  }
}
