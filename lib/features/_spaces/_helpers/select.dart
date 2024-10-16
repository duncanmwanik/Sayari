import 'package:go_router/go_router.dart';

import '../../../_helpers/debug.dart';
import '../../../_helpers/navigation.dart';
import '../../../_providers/_providers.dart';
import '../../../_services/hive/load_boxes.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_variables/navigation.dart';
import '../../../_widgets/others/toast.dart';
import '../../user/_helpers/helpers.dart';

Future<void> selectNewSpace(String spaceId, {bool pop = true}) async {
  try {
    // we do some cleaning
    state.selection.clear();
    // we load all boxes for the chosen space
    await loadSelectedSpaceBoxes(spaceId);
    // we update the current selected space id to the chosen space
    await updateSelectedSpace(spaceId);
    // we restart view at home screen again
    // so as to run the initState function in home screen
    if (pop) {
      navigatorState.currentState!.context.replace('/');
      closeDrawerIfOpened();
    }

    show('Selected space: $spaceId');
  } catch (e) {
    showToast(0, 'Could not load space.');
    logError('selectNewSpace', e);
  }
}

Future<void> updateSelectedSpace(String spaceId) async {
  await globalBox.put('${liveUser()}_currentSpaceId', spaceId);
}
