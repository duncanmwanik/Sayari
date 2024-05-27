import 'package:hive_flutter/hive_flutter.dart';

import '../../_services/firebase/sync_to_cloud.dart';
import '../../features/_tables/_helpers/common.dart';
import '../_common/global.dart';

Future<void> editItemExtras({
  String? parentId,
  required String type,
  required String itemId,
  required String key,
  required String value,
  String subId = '',
}) async {
  try {
    String tableId = parentId ?? liveTable();

    Box box = Hive.box('${tableId}_$type');
    Map itemData = box.get(itemId);

    printThis('edit $itemId --- $subId --- $key --- $value');

    bool isRemoveKey = key.startsWith('d');
    String removedKey = isRemoveKey ? key.split('/')[1] : key;

    if (isRemoveKey) {
      if (subId.isNotEmpty) {
        Map subItemData = itemData[subId];
        subItemData.remove(removedKey);
        itemData[subId] = subItemData;
      } else {
        itemData.remove(removedKey);
      }
    } else {
      if (subId.isNotEmpty) {
        Map subItemData = itemData[subId];
        subItemData[key] = value;
        itemData[subId] = subItemData;
      } else {
        itemData[key] = value;
      }
    }

    box.put(itemId, itemData);

    await syncToCloud(db: 'tables', parentId: tableId, type: type, action: 'e', itemId: itemId, subId: subId, keys: key, data: {key: value});
    //
  } catch (e) {
    errorPrint('quick-edit-$type-$key-$value', e);
  }
}
