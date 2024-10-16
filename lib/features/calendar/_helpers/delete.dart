import '../../../_helpers/navigation.dart';
import '../../../_helpers/sync/delete_item.dart';
import '../../../_models/item.dart';
import '../../../_services/notifications/create_notification.dart';

void deleteSession({required Item item}) {
  cancelScheduledNotification(item.sid);
  deleteItemForever(item);
  popWhatsOnTop(); // close dialog
}
