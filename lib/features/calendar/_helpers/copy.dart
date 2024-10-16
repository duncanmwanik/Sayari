import '../../../_helpers/debug.dart';
import '../../../_helpers/navigation.dart';
import '../../../_helpers/sync/create_item.dart';
import '../../../_helpers/sync/delete_item.dart';
import '../../../_models/item.dart';
import '../../../_providers/_providers.dart';
import '../../../_widgets/dialogs/dialog_select_date.dart';
import '../../../_widgets/others/snackbar.dart';

void copySessionToDates({required Item item, required bool move}) async {
  safeRun(
    where: 'copySessionToDates-move:$move',
    () async {
      await showDateDialog(
        isMultiple: true,
        showTitle: true,
        title: 'Select dates to ${move ? 'move' : 'copy'} session',
      ).then((newDates) async {
        if (newDates.isEmpty) return;

        closeDialog(); // close date dialog
        closeBottomSheetIfOpen();
        showSnackBar('${move ? 'Moving' : 'Copying'} session...');

        state.input.set(item);
        state.input.updateSelectedDates('set', dates: newDates);
        createItem();
        if (move) deleteItemForever(item);
      });
    },
  );
}
