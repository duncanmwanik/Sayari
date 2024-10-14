import 'package:hive/hive.dart';

import '../../../_helpers/debug.dart';
import '../../../_models/item.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/get_data.dart';
import '../../_spaces/_helpers/common.dart';
import '../../files/_helpers/handler.dart';

Future<void> deleteItemForever(Item item) async {
  safeRun(
    where: 'deleteItemForever',
    () async {
      printThis('delete ${item.parent} ${item.id} ${item.sid}');
      Box box = storage(item.parent);
      if (item.sid.isNotEmpty) {
        Map itemData = box.get(item.id);
        itemData.remove(item.sid);
        box.put(item.id, itemData);
      } else {
        await box.delete(item.id);
      }

      syncToCloud(db: 'spaces', space: liveSpace(), parent: item.parent, action: 'd', id: item.id, sid: item.sid);
      handleFilesDeletion(liveSpace(), item.files());
    },
  );
}
