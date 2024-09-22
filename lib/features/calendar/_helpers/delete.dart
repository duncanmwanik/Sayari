import '../../../_helpers/_common/global.dart';
import '../../../_models/item.dart';
import '../../../_services/notifications/create_notification.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/others/toast.dart';
import '../../_notes/_helpers/delete_item.dart';
import '../../files/_helpers/helper.dart';

void deleteSession({required Item item}) async {
  try {
    // TODOs: cancel well reminders
    cancelScheduledNotification(item.id);
    deleteItemForever(type: feature.calendar, itemId: item.extra, subId: item.id, files: getFiles(item.data));
  } catch (e) {
    showToast(0, 'Could not delete session');
    errorPrint('delete-session', e);
  }
}
