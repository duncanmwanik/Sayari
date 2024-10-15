import '../../../_helpers/debug.dart';
import '../../../_providers/_providers.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/store.dart';
import '../../../_variables/features.dart';

Future<void> deleteTag(String tagId) async {
  try {
    await storage(feature.tags).delete(tagId);
    if (state.views.selectedTag == tagId) state.views.updateSelectedTag('All');
    await syncToCloud(db: 'spaces', parent: feature.tags, action: 'd', id: tagId);
  } catch (e) {
    logError('delete-tag', e);
  }
}
