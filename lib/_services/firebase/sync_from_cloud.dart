import 'package:hive_flutter/hive_flutter.dart';

import '../../_helpers/_common/global.dart';
import '../../_variables/features.dart';
import '../activity/save_activity.dart';
import 'firebase_database.dart';

Future<bool> syncFromCloud(String parentId, String timestamp, String activity) async {
  try {
    // '$db,$type,$action,$itemId,$subId,$keys,$extras,$userName'
    List<String> activityData = getSplitList(activity, separator: ',', clearEmpties: false);
    String db = activityData[0];
    String type = activityData[1];
    String action = activityData[2];
    String itemId = activityData[3];
    String subId = activityData[4];
    String keys = activityData[5];
    String extras = activityData[6];
    String userName = activityData[7];

    printThis('::Updating-> $db,$type,$action,$itemId,$subId,$keys,$extras,$userName');

    Box box = await Hive.openBox('${parentId}_$type');

    //
    // create --------------------------------------------------
    //
    if (action == 'c') {
      //
      // for session ops
      //
      if (feature.isSession(type)) {
        String firstDate = getSplitList(extras).first;

        await cloudService.getData(db: db, '$parentId/$type/$firstDate/$itemId').then((snapshot) async {
          var data = snapshot.value as Map;

          if (data.isNotEmpty) {
            for (String date in getSplitList(extras)) {
              Map sessionMap = box.get(date, defaultValue: {});
              sessionMap[itemId] = data;
              await box.put(date, sessionMap);
            }
          }
        });
      }
      //
      //
      else if (db == 'users') {
        if (subId.isNotEmpty) {
          Map itemData = box.get(itemId, defaultValue: {});
          itemData[subId] = 0;
          await box.put(itemId, itemData);
          box.put(itemId, {subId: 0});
        } else {
          await box.put(itemId, 0);
        }
      }
      //
      // others
      //
      else {
        await cloudService.getData(db: db, '$parentId/$type${itemId.isNotEmpty ? '/$itemId' : ''}${subId.isNotEmpty ? '/$subId' : ''}').then((snapshot) async {
          var data = snapshot.value;

          if (data != null) {
            bool isMap = data.runtimeType.toString().contains('Map');
            if (isMap) {
              (data as Map)['z'] = timestamp; // set time of edit
              // if (subId.isEmpty) title = (data)['t'];
            }

            if (subId.isNotEmpty) {
              Map itemData = box.get(itemId);
              itemData[subId] = data;
              itemData['z'] = timestamp; // set time of edit
              await box.put(itemId, itemData);
            } else {
              if (itemId.isNotEmpty) {
                await box.put(itemId, data);
              } else {
                await box.putAll(data as Map);
              }
            }
          }
        });
      }
    }
    //
    // edit -------------------------------------------------- edit
    //
    if (action == 'e') {
      getSplitList(keys).forEach((editedKey) async {
        //
        // delete key
        //
        if (editedKey.startsWith('d')) {
          String key = editedKey.split('/')[1];
          Map itemData = box.get(itemId, defaultValue: {});

          if (subId.isNotEmpty) {
            Map subItemData = itemData[subId];
            subItemData.remove(key);
            subItemData['z'] = timestamp; // set time of edit
            itemData[subId] = subItemData;
            await box.put(itemId, itemData);
          } else {
            if (itemId.isNotEmpty) {
              itemData.remove(key);
              itemData['z'] = timestamp; // set time of edit
              await box.put(itemId, itemData);
            } else {
              await box.delete(key);
            }
          }
        }
        //
        // add/edit item key
        //
        else {
          //
          await cloudService.getData(db: db, '$parentId/$type${itemId.isNotEmpty ? '/$itemId' : ''}${subId.isNotEmpty ? '/$subId' : ''}/$editedKey').then((snapshot) async {
            var value = snapshot.value;

            if (value != null) {
              Map itemData = box.get(itemId, defaultValue: {});

              if (subId.isNotEmpty) {
                Map subItemData = itemData[subId];
                subItemData[editedKey] = value;
                subItemData['z'] = timestamp; // set time of edit
                itemData[subId] = subItemData;
                await box.put(itemId, itemData);
              } else {
                if (itemId.isNotEmpty) {
                  itemData[editedKey] = value;
                  itemData['z'] = timestamp; // set time of edit
                  await box.put(itemId, itemData);
                } else {
                  await box.put(editedKey, value);
                }
              }
            }
          });
        }

        //
      });
    }
    //
    // delete --------------------------------------------------
    //
    if (action == 'd') {
      if (subId.isNotEmpty) {
        Map itemData = box.get(itemId);
        itemData.remove(subId);
        await box.put(itemId, itemData);
      } else {
        await box.delete(itemId);
      }
    }

    await saveActivity(parentId, timestamp, activity);

    return true;
  } catch (e) {
    errorPrint('sync-from-cloud', e);
    return false;
  }
}
