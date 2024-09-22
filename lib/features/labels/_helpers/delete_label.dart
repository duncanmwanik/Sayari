import 'package:hive/hive.dart';

import '../../../_helpers/_common/global.dart';
import '../../../_providers/_providers.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_variables/features.dart';
import '../../_spaces/_helpers/common.dart';

Future<void> deleteLabel(String label) async {
  try {
    await Hive.box('${liveSpace()}_${feature.labels}').delete(label);
    if (state.views.selectedLabel == label) {
      state.views.updateSelectedLabel('All');
    }

    await syncToCloud(db: 'spaces', parentId: liveSpace(), type: feature.cloud(feature.flags), action: 'd', itemId: label);
  }
  //
  catch (e) {
    errorPrint('delete-label', e);
  }
}
