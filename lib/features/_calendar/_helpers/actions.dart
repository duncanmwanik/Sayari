import '../../../_helpers/_common/global.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_models/item.dart';
import '../../../_providers/providers.dart';
import '../../../_services/notifications/create_notification.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/dialogs/dialog_select_date.dart';
import '../../../_widgets/others/snackbar.dart';
import '../../../_widgets/others/toast.dart';
import '../../_notes/_helpers/create_item.dart';
import '../../_notes/_helpers/delete_item.dart';
import '../../files/_helpers/helper.dart';

void copySessionToDates({required Item item, required bool move}) async {
  try {
    await showSelectDateDialog(isMultiple: true).then((newDates) async {
      if (newDates.isEmpty) return;

      closeDialog(); // close confirmation dialog
      closeBottomSheetIfOpen();

      showSnackBar('${move ? 'Moving' : 'Copying'} session to selected dates...');

      state.input.setInputData(typ: feature.calendar.t, id: item.id, dta: item.data);
      state.input.updateSelectedDates('set', dates: newDates);
      createItem();
      if (move) {
        deleteItemForever(type: feature.calendar.t, itemId: item.extra, subId: item.id, files: getFiles(item.data));
      }
    });
    //
  } catch (e) {
    errorPrint('${move ? 'move' : 'copy'}-session', e);
  }
}

void deleteSession({required Item item}) async {
  try {
    // TODOs: cancel well reminders
    cancelScheduledNotification(item.id);
    deleteItemForever(type: feature.calendar.t, itemId: item.extra, subId: item.id, files: getFiles(item.data));
  } catch (e) {
    showToast(0, 'Could not delete session');
    errorPrint('delete-session', e);
  }
}
