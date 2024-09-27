import '../../../_helpers/navigation.dart';
import '../../../_models/item.dart';
import '../../../_services/notifications/create_notification.dart';
import '../../_notes/_helpers/delete_item.dart';

void deleteSession({required Item item}) {
  cancelScheduledNotification(item.sid);
  deleteItemForever(item);
  popWhatsOnTop(); // close dialog
}
