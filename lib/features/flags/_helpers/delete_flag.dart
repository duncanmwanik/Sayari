import '../../../_helpers/debug.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/get_data.dart';
import '../../../_variables/features.dart';
import '../../_spaces/_helpers/common.dart';

Future<void> deleteFlag(String flag) async {
  try {
    String spaceId = liveSpace();
    storage(feature.flags).delete(flag);
    await syncToCloud(db: 'spaces', space: spaceId, parent: feature.flags, action: 'd', id: flag);
  } catch (e) {
    errorPrint('delete-flag', e);
  }
}
