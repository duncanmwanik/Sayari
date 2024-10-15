import '../../_helpers/debug.dart';
import '../../_helpers/navigation.dart';
import '../hive/local_storage_service.dart';
import '../hive/store.dart';

bool isActivityActedOn(String spaceId, String timestamp) {
  try {
    return storage('activity', space: spaceId).containsKey(timestamp);
  } catch (e) {
    logError('is-activity-acted-on', e);
    return false;
  }
}

Future<void> deleteActivity(String activityId) async {
  try {
    storage('activity').delete(activityId);
    popWhatsOnTop();
  } catch (e) {
    logError('delete-activity-for-user', e);
  }
}

String lastActivity(String subject) => activityVersionBox.get(subject, defaultValue: '');
