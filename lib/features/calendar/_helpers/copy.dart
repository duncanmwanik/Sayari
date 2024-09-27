import '../../../_helpers/debug.dart';
import '../../../_helpers/navigation.dart';
import '../../../_models/item.dart';
import '../../../_providers/_providers.dart';
import '../../../_widgets/dialogs/dialog_select_date.dart';
import '../../../_widgets/others/snackbar.dart';
import '../../_notes/_helpers/create_item.dart';
import '../../_notes/_helpers/delete_item.dart';

void copySessionToDates({required Item item, required bool move}) async {
  safeRun(
    where: 'copySessionToDates-move:$move',
    () async {
      await showSelectDateDialog(
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
