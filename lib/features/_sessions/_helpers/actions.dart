import '../../../_helpers/_common/global.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_helpers/date_time/date_info.dart';
import '../../../_helpers/items/create_item.dart';
import '../../../_helpers/items/delete_item.dart';
import '../../../_helpers/notifications/create_notification.dart';
import '../../../_providers/providers.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/abcs/dialogs_sheets/confirmation_dialog.dart';
import '../../../_widgets/abcs/dialogs_sheets/dialog_select_date.dart';
import '../../../_widgets/others/snackbar.dart';
import '../../../_widgets/others/toast.dart';
import '../../files/_helpers/helper.dart';

void copySessionToDates({
  required String previousDate,
  required String sessionId,
  required Map sessionData,
  required bool move,
}) async {
  try {
    await showSelectDateDialog(isMultiple: true).then((newDates) async {
      closeDialog(); // close confirmation dialog
      closeBottomSheetIfOpen();

      showSnackBar('${move ? 'Moving' : 'Copying'} session to selected dates...');

      state.input.setInputData(typ: feature.sessions.t, id: sessionId, dta: sessionData);
      state.input.updateSelectedDates('set', dates: newDates);
      createItem();
      if (move) {
        deleteItemForever(
            type: feature.sessions.t, itemId: previousDate, subId: sessionId, files: getFiles(sessionData));
      }
    });
    //
  } catch (e) {
    errorPrint('${move ? 'move' : 'copy'}-session', e);
  }
}

void deleteSession({
  required String sessionDate,
  required String sessionId,
  required String sessionName,
  required Map sessionData,
}) async {
  try {
    await showConfirmationDialog(
      title: 'Delete <b>$sessionName</b> on <b>${getDayInfo(sessionDate)}</b>?',
      yeslabel: 'Delete',
      onAccept: () async {
        closeDialog(); // close overview dialog
        // TODOs: cancel well reminders
        cancelScheduledNotification(sessionId);
        deleteItemForever(
            type: feature.sessions.t, itemId: sessionDate, subId: sessionId, files: getFiles(sessionData));
      },
    );
  } catch (e) {
    showToast(0, 'Could not delete session');
    errorPrint('delete-session', e);
  }
}
