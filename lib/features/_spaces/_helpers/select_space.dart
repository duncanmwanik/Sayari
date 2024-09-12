import 'package:go_router/go_router.dart';

import '../../../_helpers/_common/global.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_providers/providers.dart';
import '../../../_services/hive/load_boxes.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_variables/navigation.dart';
import '../../../_widgets/others/toast.dart';
import '../../user/_helpers/set_user_data.dart';

Future<void> selectNewSpace(String spaceId, {bool isFirstTime = false}) async {
  try {
    // if the chosen space is not the currently selected space
    // we clear any item selection from previous space
    state.selection.clearAnyItemSelections();
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
