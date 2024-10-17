import '../../../_helpers/debug.dart';
import '../../../_helpers/global.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/store.dart';
import '../../../_variables/features.dart';

Future<void> addNewTag(String tagColor, String tagName) async {
  try {
    String tagId = getUniqueId();
    String tagData = '$tagColor,$tagName';
    storage(feature.tags).put(tagId, tagData);
    await syncToCloud(db: 'spaces', parent: feature.tags, id: tagId, data: tagData, action: 'c');
  } catch (e) {
    logError('addNewTag', e);
  }
}
