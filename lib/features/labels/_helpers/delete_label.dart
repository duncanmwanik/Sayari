import 'package:hive/hive.dart';

import '../../../_helpers/_common/global.dart';
import '../../../_providers/providers.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_variables/features.dart';
import '../../_tables/_helpers/common.dart';

Future<void> deleteLabel(String label) async {
  try {
    await Hive.box('${liveTable()}_${feature.labels.t}').delete(label);
    if (state.labels.selectedLabel == label) {
      state.labels.updateSelectedLabel('All');
    }

    await syncToCloud(db: 'tables', parentId: liveTable(), type: feature.labels.t, action: 'd', itemId: label);
  }
  //
  catch (e) {
    errorPrint('delete-label', e);
  }
}
