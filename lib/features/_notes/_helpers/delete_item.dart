import 'package:hive/hive.dart';

import '../../../_helpers/_common/global.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../_tables/_helpers/common.dart';
import '../../files/_helpers/upload.dart';
import 'share.dart';

Future<void> deleteItemForever(
    {required String type, required String itemId, String subId = '', required Map files}) async {
  try {
    String tableId = liveTable();

    printThis('delete $type --- $itemId --- $subId');

    Box box = Hive.box('${tableId}_$type');

    if (subId.isNotEmpty) {
      Map itemData = box.get(itemId);
      itemData.remove(subId);
      box.put(itemId, itemData);
    } else {
      await box.delete(itemId);
    }

    syncToCloud(db: 'tables', parentId: tableId, type: type, action: 'd', itemId: itemId, subId: subId);
    shareItem(delete: true, itemId: itemId);
    handleFilesDeletion(tableId, files);
    //
  } catch (e) {
    errorPrint('delete-item-forever-$type', e);
  }
}
