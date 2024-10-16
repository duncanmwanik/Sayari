import 'package:hive_flutter/hive_flutter.dart';

import '../../_services/firebase/sync_to_cloud.dart';
import '../../_services/hive/store.dart';
import '../debug.dart';

Future<void> quickEdit({
  String? space,
  required String parent,
  required String id,
  required String key,
  String? value,
  String sid = '',
}) async {
  try {
    Box box = storage(parent);
    Map itemData = box.get(id);

    show('edit $id --- $sid --- $key --- $value');

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

    await syncToCloud(db: 'spaces', space: space, parent: parent, action: 'e', id: id, sid: sid, keys: key, data: {key: value});
    //
  } catch (e) {
    logError('quick-edit-$parent-$key-$value', e);
  }
}
