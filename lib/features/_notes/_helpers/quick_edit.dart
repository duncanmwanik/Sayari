import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/debug.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/get_data.dart';
import '../../_spaces/_helpers/common.dart';

Future<void> editItemExtras({
  String? space,
  required String parent,
  required String id,
  required String key,
  String? value,
  String sid = '',
}) async {
  try {
    String spaceId = space ?? liveSpace();

    Box box = storage(parent);
    Map itemData = box.get(id);

    printThis('edit $id --- $sid --- $key --- $value');

    bool isRemoveKey = key.startsWith('d');
    String removedKey = isRemoveKey ? key.split('/')[1] : key;

    if (isRemoveKey) {
      if (sid.isNotEmpty) {
        Map subItemData = itemData[sid];
        subItemData.remove(removedKey);
        itemData[sid] = subItemData;
      } else {
        itemData.remove(removedKey);
      }
    } else {
      if (sid.isNotEmpty) {
        Map subItemData = itemData[sid];
        subItemData[key] = value;
        itemData[sid] = subItemData;
      } else {
        itemData[key] = value;
      }
    }

    box.put(id, itemData);

    await syncToCloud(db: 'spaces', space: spaceId, parent: parent, action: 'e', id: id, sid: sid, keys: key, data: {key: value});
    //
  } catch (e) {
    errorPrint('quick-edit-$parent-$key-$value', e);
  }
}
