import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/get_data.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_variables/features.dart';
import '../../_spaces/_helpers/checks_space.dart';
import '../../_spaces/_helpers/common.dart';

Future<void> deleteMessageForUser(String id) async {
  try {
    await storage(feature.chat).delete(id);
    await pendingBox.delete(id);
    if (isAdmin()) await syncToCloud(db: 'spaces', space: liveSpace(), parent: feature.chat, action: 'd', id: id);
  } catch (e) {
    //
  }
}
