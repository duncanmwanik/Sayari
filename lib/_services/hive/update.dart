import 'package:hive/hive.dart';

import '../../_helpers/debug.dart';

Future<bool> updateStore({
  required String db,
  required String space,
  String parent = '',
  required String action,
  var data,
  String id = '',
  String sid = '',
  String keys = '',
}) async {
  //!
  bool success = false;
  //
  try {
    bool isNew = action.startsWith('c');
    bool isEdit = action.startsWith('e');
    bool isDelete = action.startsWith('d');
    // bool isForSession = parent == feature.calendar;

    Box box = await Hive.openBox('${space}_$parent');
    //
    // new stuff
    //
    if (isNew) {
      if (sid.isNotEmpty) {
        Map itemData = box.get(id, defaultValue: {});
        itemData[sid] = data;
        await box.put(id, itemData);
      } else {
        await box.put(id, data);
      }
    }
    //
    // editing
    //
    else if (isEdit) {
    }
    //
    //deleting items
    //
    else if (isDelete) {
      if (sid.isNotEmpty) {
        Map itemData = box.get(id);
        itemData.remove(sid);
        await box.put(id, itemData);
      } else {
        await box.delete(id);
      }
    }
    //
    success = true; // successful
    //
  } catch (e) {
    errorPrint('updateStore-$parent-$action-$id-$sid-$keys-$data', e);
    //
  }

  return success;
}
