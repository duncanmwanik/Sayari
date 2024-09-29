import 'package:go_router/go_router.dart';

import '../../../_helpers/debug.dart';
import '../../../_helpers/navigation.dart';
import '../../../_providers/_providers.dart';
import '../../../_services/hive/load_boxes.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_variables/navigation.dart';
import '../../../_widgets/others/toast.dart';
import '../../user/_helpers/helpers.dart';

Future<void> selectNewSpace(String spaceId, {bool isFirstTime = false}) async {
  try {
    // if the chosen space is not the currently selected space
    // we clear any item selection from previous space
    state.selection.clear();
    // we load all boxes for the chosen space
    await loadSelectedSpaceBoxes(spaceId);
    // we update the current selected space id to the chosen space
    await updateSelectedSpace(spaceId);
    // we restart view at home screen again
    // so as to run the initState function in home screen
    if (!isFirstTime) {
      navigatorState.currentState!.context.replace('/');
      closeDrawerIfOpened();
    }

    printThis('Selected space: $spaceId');
  } catch (e) {
    showToast(0, 'Could not load space');
    errorPrint('select-space', e);
  }
}

Future<void> updateSelectedSpace(String spaceId, {String? signUpUserId}) async {
  await globalBox.put('${signUpUserId ?? liveUser()}_currentSpaceId', spaceId);
}
