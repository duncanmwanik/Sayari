import 'package:hive/hive.dart';

import '../../../_helpers/_common/global.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_variables/features.dart';
import '../../_spaces/_helpers/common.dart';
import '../../files/_helpers/handler.dart';
import '../../share/_helpers/share.dart';

Future<void> deleteItemForever({required String type, required String itemId, String subId = '', required Map files}) async {
  try {
    String spaceId = liveSpace();

    printThis('delete $type --- $itemId --- $subId');

    Box box = Hive.box('${spaceId}_$type');

    if (subId.isNotEmpty) {
      Map itemData = box.get(itemId);
      itemData.remove(subId);
      box.put(itemId, itemData);
    } else {
      await box.delete(itemId);
    }

    syncToCloud(db: 'spaces', parentId: spaceId, type: feature.cloud(type), action: 'd', itemId: itemId, subId: subId);
    shareItem(delete: true, itemId: itemId);
    handleFilesDeletion(spaceId, files);
    //
  } catch (e) {
    errorPrint('delete-item-forever-$type', e);
  }
}
