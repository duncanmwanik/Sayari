import 'package:hive/hive.dart';

import '../../../_helpers/_common/global.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../_spaces/_helpers/common.dart';

Future<void> orderItems({
  required String type,
  required String itemId,
  required int itemsLength,
  required int oldIndex,
  required int newIndex,
  bool applyIndexFix = true,
}) async {
  try {
    String spaceId = liveSpace();
    Box box = Hive.box('${spaceId}_$type');

    if (applyIndexFix) {
      if (newIndex > itemsLength) newIndex = itemsLength;
      if (oldIndex < newIndex) newIndex--;
    }

    print('$oldIndex >> $newIndex');

    Map itemData = box.get(itemId, defaultValue: {});
    // List ol = box.get('ol', defaultValue: box.keys.toList().reversed.toList());

    if (itemData.isNotEmpty) {
      itemData['o'] = newIndex.toString();
      box.put(itemId, itemData);
      await syncToCloud(
          db: 'spaces',
          parentId: spaceId,
          type: type,
          action: 'e',
          itemId: itemId,
          keys: 'o',
          data: {'o': newIndex.toString()});
    }

    Map all = box.toMap();
    List allKeys = box.keys
        .where((key) => key != itemId && all[key]['o'] != null && int.parse(all[key]['o']) >= newIndex)
        .toList();
    print(allKeys);
    allKeys.sort((k1, k2) => int.parse(all[k1]['o']).compareTo(int.parse(all[k2]['o'])));

    for (var key in allKeys) {
      if (int.parse(all[key]['o']) < (all.length - 1)) {
        String newIndex = (int.parse(all[key]['o']) + 1).toString();
        all[key]['o'] = newIndex;
        await syncToCloud(
            db: 'spaces', parentId: spaceId, type: type, action: 'e', itemId: key, keys: 'o', data: {'o': newIndex});
      }
    }

    box.putAll(all);
    //
    //
  } catch (e) {
    errorPrint('order-items-$type-$itemId', e);
  }
}

 // Future<void> orderItems({
//   required String type,
//   required String itemId,
//   required int itemsLength,
//   required int oldIndex,
//   required int newIndex,
//   bool applyIndexFix = true,
// }) async {
//   try {
//     String spaceId = liveSpace();
//     Box box = Hive.box('${spaceId}_$type');

//     if (applyIndexFix) {
//       if (newIndex > itemsLength) newIndex = itemsLength;
//       if (oldIndex < newIndex) newIndex--;
//     }

//     print('$oldIndex >> $newIndex');

//     Map itemData = box.get(itemId, defaultValue: {});
//     if (itemData.isNotEmpty) {
//       itemData['o'] = newIndex.toString();
//       box.put(itemId, itemData);
//       await syncToCloud(db: 'spaces', parentId: spaceId, type: type, action: 'e', itemId: itemId, keys: 'o', data: {'o': newIndex.toString()});
//     }

//     Map all = box.toMap();
//     List allKeys = box.keys.where((key) => key != itemId && all[key]['o'] != null && int.parse(all[key]['o']) >= newIndex).toList();
//     print(allKeys);
//     allKeys.sort((k1, k2) => int.parse(all[k1]['o']).compareTo(int.parse(all[k2]['o'])));

//     for (var key in allKeys) {
//       if (int.parse(all[key]['o']) < (all.length - 1)) {
//         String newIndex = (int.parse(all[key]['o']) + 1).toString();
//         all[key]['o'] = newIndex;
//         await syncToCloud(db: 'spaces', parentId: spaceId, type: type, action: 'e', itemId: key, keys: 'o', data: {'o': newIndex});
//       }
//     }

//     box.putAll(all);
//     //
//     //
//   } catch (e) {
//     errorPrint('order-items-$type-$itemId', e);
//   }
// }
