import 'package:go_router/go_router.dart';

import '../../../_helpers/_common/global.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_helpers/user/set_user_data.dart';
import '../../../_providers/providers.dart';
import '../../../_services/hive/load_boxes.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_variables/navigation.dart';
import '../../../_widgets/others/toast.dart';

Future<void> selectNewTable(String tableId, {bool isFirstTime = false}) async {
  try {
    // if the chosen table is not the currently selected table
    // we clear any item selection from previous table
    state.selection.clearAnyItemSelections();
    // we load all boxes for the chosen table
    await loadSelectedTableBoxes(tableId);
    // we update the current selected table id to the chosen table
    await updateSelectedTable(tableId);
    // we restart view at home screen again
    // so as to run the initState function in home screen
    if (!isFirstTime) {
      navigatorState.currentState!.context.replace('/');
      closeDrawerIfOpened();
    }

    printThis('Selected table: $tableId');
  } catch (e) {
    showToast(0, 'Could not load table');
    errorPrint('select-table', e);
  }
}

Future<void> updateSelectedTable(String tableId, {String? signUpUserId}) async {
  await globalBox.put('${signUpUserId ?? liveUser()}_currentTableId', tableId);
}
