import '../../_helpers/debug.dart';
import '../../_helpers/navigation.dart';
import '../hive/get_data.dart';
import '../hive/local_storage_service.dart';

bool isActivityActedOn(String spaceId, String timestamp) {
  try {
    return storage('activity', spaceId: spaceId).containsKey(timestamp);
  } catch (e) {
    errorPrint('is-activity-acted-on', e);
    return false;
  }
}

Future<void> deleteActivity(String activityId) async {
  try {
    storage('activity').delete(activityId);
    popWhatsOnTop();
  } catch (e) {
    errorPrint('delete-activity-for-user', e);
  }
}

String lastActivity(String subject) => activityVersionBox.get(subject, defaultValue: '');
