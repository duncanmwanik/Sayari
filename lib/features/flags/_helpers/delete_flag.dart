import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/_common/global.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_variables/features.dart';
import '../../_tables/_helpers/common.dart';

Future<void> deleteFlag(String flag) async {
  try {
    String tableId = liveTable();
    Hive.box('${liveTable()}_${feature.flags.t}').delete(flag);
    await syncToCloud(db: 'tables', parentId: tableId, type: feature.flags.t, action: 'd', itemId: flag);
  } catch (e) {
    errorPrint('delete-flag', e);
  }
}
