//

import '../../../_helpers/global.dart';
import '../../../_providers/_providers.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_variables/features.dart';
import '../../_spaces/_helpers/common.dart';

void addQuickTaskItem() {
  try {
    String id = getUniqueId();
    state.input.addAll({
      'z': id,
      'o': id,
    });
    Map data = {...state.input.item.data};
    state.input.clear();
    state.focus.reset();

    syncToCloud(db: 'spaces', space: liveSpace(), action: 'c', parent: feature.timeline, id: feature.tasks, sid: id, data: data);
  } catch (e) {
    //
  }
}
