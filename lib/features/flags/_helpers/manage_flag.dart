import '../../../_helpers/debug.dart';
import '../../../_helpers/global.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/get_data.dart';
import '../../../_variables/features.dart';
import '../../_spaces/_helpers/common.dart';

Future<void> createFlag(String flagData) async {
  try {
    String spaceId = liveSpace();
    String flagId = getUniqueId();
    storage(feature.flags).put(flagId, flagData);
    await syncToCloud(db: 'spaces', space: spaceId, parent: feature.flags, action: 'c', id: flagId, data: flagData);
  } catch (e) {
    errorPrint('add-flag', e);
  }
}

Future<void> editFlag(String flagId, String flagData) async {
  try {
    String spaceId = liveSpace();
    storage(feature.flags).put(flagId, flagData);
    await syncToCloud(db: 'spaces', space: spaceId, parent: feature.flags, action: 'c', id: flagId, data: flagData);
  } catch (e) {
    errorPrint('edit-flag', e);
  }
}

Future<void> deleteFlag(String flagId) async {
  try {
    String spaceId = liveSpace();
    storage(feature.flags).delete(flagId);
    await syncToCloud(db: 'spaces', space: spaceId, parent: feature.flags, action: 'd', id: flagId);
  } catch (e) {
    errorPrint('delete-flag', e);
  }
}
