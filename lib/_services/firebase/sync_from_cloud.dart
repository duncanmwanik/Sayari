import 'package:hive_flutter/hive_flutter.dart';

import '../../_helpers/debug.dart';
import '../../_helpers/global.dart';
import '../../_variables/features.dart';
import '../activity/save_activity.dart';
import '../hive/store.dart';
import 'database.dart';

Future<bool> syncFromCloud(String space, String timestamp, String activity) async {
  bool success = false;
  try {
    List<String> activityData = splitList(activity, separator: ',', clearEmpties: false);
    String db = activityData[0];
    String parent = activityData[1];
    String action = activityData[2];
    String id = activityData[3];
    String sid = activityData[4];
    String keys = activityData[5];
    String extras = activityData[6];
    String userName = activityData[7];

    bool isNew = action.startsWith('c');
    bool isEdit = action.startsWith('e');
    bool isDelete = action.startsWith('d');
    bool isForSession = parent.isCalendar();

    show('::syncFromCloud: $db,$space,$parent,$action,$id,$sid,$keys,$extras,$userName');
    Box box = storage(parent, space: space);

    //
    // new
    //
    if (isNew) {
      // for sessions
      if (isForSession) {
        await cloudService.getData(db: db, '$space/$parent/${splitList(extras).first}/$id').then((snapshot) async {
          var data = snapshot.value as Map;

          if (data.isNotEmpty) {
            for (String date in splitList(extras)) {
              Map sessionMap = box.get(date, defaultValue: {});
              sessionMap[id] = data;
              await box.put(date, sessionMap);
            }
          }
        });
      }
      // others
      else {
        await cloudService
            .getData(db: db, '$space/$parent${id.isNotEmpty ? '/$id' : ''}${sid.isNotEmpty ? '/$sid' : ''}')
            .then((snapshot) async {
          var data = snapshot.value;

          if (data != null) {
            if (sid.isNotEmpty) {
              Map itemData = box.get(id, defaultValue: {});
              itemData[sid] = data;
              await box.put(id, itemData);
            } else {
              if (id.isNotEmpty) {
                await box.put(id, data);
              } else {
                await box.putAll(data as Map);
              }
            }
          }
        });
      }
    }
    //
    // edit
    //
    if (isEdit) {
      splitList(keys).forEach((editedKey) async {
        // delete key
        if (editedKey.startsWith('d')) {
          String key = editedKey.split('/')[1];
          Map itemData = box.get(id, defaultValue: {});

          if (sid.isNotEmpty) {
            Map subItemData = itemData[sid];
            subItemData.remove(key);
            itemData[sid] = subItemData;
            await box.put(id, itemData);
          } else {
            if (id.isNotEmpty) {
              itemData.remove(key);
              await box.put(id, itemData);
            } else {
              await box.delete(key);
            }
          }
        }
        // add/edit item key
        else {
          await cloudService
              .getData(db: db, '$space/$parent${id.isNotEmpty ? '/$id' : ''}${sid.isNotEmpty ? '/$sid' : ''}/$editedKey')
              .then((snapshot) async {
            var value = snapshot.value;

            if (value != null) {
              Map itemData = box.get(id, defaultValue: {});

              if (sid.isNotEmpty) {
                Map subItemData = itemData[sid];
                subItemData[editedKey] = value;
                itemData[sid] = subItemData;
                await box.put(id, itemData);
              } else {
                if (id.isNotEmpty) {
                  itemData[editedKey] = value;
                  await box.put(id, itemData);
                } else {
                  await box.put(editedKey, value);
                }
              }
            }
          });
        }
      });
    }
    //
    // delete
    //
    if (isDelete) {
      if (sid.isNotEmpty) {
        Map itemData = box.get(id);
        itemData.remove(sid);
        await box.put(id, itemData);
      } else {
        await box.delete(id);
      }
    }

    await saveActivity(space, timestamp, activity);

    success = true;
  } catch (e) {
    logError('syncFromCloud', e);
    success = false;
  }

  return success;
}
