import '../../../_helpers/debug.dart';
import '../../../_providers/_providers.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/get_data.dart';
import '../../../_variables/features.dart';
import '../../_spaces/_helpers/common.dart';

Future<void> deleteLabel(String label) async {
  try {
    await storage(feature.labels).delete(label);
    if (state.views.selectedLabel == label) {
      state.views.updateSelectedLabel('All');
    }

    await syncToCloud(db: 'spaces', space: liveSpace(), parent: feature.flags, action: 'd', id: label);
  }
  //
  catch (e) {
    errorPrint('delete-label', e);
  }
}
