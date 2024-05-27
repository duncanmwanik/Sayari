import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/_common/global.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_variables/features.dart';
import '../../_tables/_helpers/common.dart';

Future<void> editFlag(String newFlag, String color, String previousFlag) async {
  try {
    String tableId = liveTable();
    Hive.box('${liveTable()}_${feature.flags.t}').put(newFlag, color);
    Hive.box('${liveTable()}_${feature.flags.t}').delete(previousFlag);

    await syncToCloud(db: 'tables', parentId: tableId, type: feature.flags.t, action: 'd', itemId: previousFlag);
    await syncToCloud(db: 'tables', parentId: tableId, type: feature.flags.t, action: 'c', itemId: newFlag, data: color);
  } catch (e) {
    errorPrint('edit-flag', e);
  }
}
