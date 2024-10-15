import '../../../_helpers/debug.dart';
import '../../../_models/item.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/sync.dart';
import '../../files/_helpers/handler.dart';

Future<void> deleteItemForever(Item item) async {
  safeRun(
    where: 'deleteItemForever',
    () async {
      show('delete ${item.parent} ${item.id} ${item.sid}');
      syncStore(parent: item.parent, action: 'd', id: item.id, sid: item.sid, data: item.data);
      syncToCloud(db: 'spaces', parent: item.parent, action: 'd', id: item.id, sid: item.sid);
      handleFilesDeletion(item.files());
    },
  );
}
