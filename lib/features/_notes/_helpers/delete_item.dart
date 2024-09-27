import 'package:hive/hive.dart';

import '../../../_helpers/debug.dart';
import '../../../_models/item.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/get_data.dart';
import '../../_spaces/_helpers/common.dart';
import '../../files/_helpers/handler.dart';
import '../../share/_helpers/share.dart';

Future<void> deleteItemForever(Item item) async {
  safeRun(
    where: 'deleteItemForever',
    () async {
      printThis('delete ${item.parent} ${item.id} ${item.sid}');
      String spaceId = liveSpace();

      Box box = storage(item.parent);

      if (item.sid.isNotEmpty) {
        Map itemData = box.get(item.id);
        itemData.remove(item.sid);
        box.put(item.id, itemData);
      } else {
        await box.delete(item.id);
      }

      syncToCloud(db: 'spaces', space: spaceId, parent: item.parent, action: 'd', id: item.id, sid: item.sid);
      shareItem(delete: true, id: item.id);
      handleFilesDeletion(spaceId, item.files());
    },
  );
}
