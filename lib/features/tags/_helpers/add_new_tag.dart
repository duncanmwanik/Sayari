import '../../../_helpers/debug.dart';
import '../../../_helpers/global.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/store.dart';
import '../../../_variables/constants.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/others/toast.dart';

Future<void> addNewTag(String tag) async {
  try {
    // if tag does not exist already or is a default tag
    if (storage(feature.tags).containsKey(tag) || specialTagsIcons.keys.contains(tag)) {
      // Future helps us show the toast consistently : bug
      Future.delayed(Duration(seconds: 0), () => showToast(0, 'Tag already exists!'));
    }
    //
    else {
      String tagId = getUniqueId();
      String tagData = 'x,$tag';
      storage(feature.tags).put(tagId, tagData);
      await syncToCloud(db: 'spaces', parent: feature.tags, action: 'c', id: tagId, data: tagData);
    }
    //
  } catch (e) {
    logError('add-tag', e);
  }
}
