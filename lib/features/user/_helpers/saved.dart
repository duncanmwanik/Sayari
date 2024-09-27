import 'package:go_router/go_router.dart';

import '../../../_helpers/global.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_variables/navigation.dart';
import '../../../_widgets/buttons/action.dart';
import '../../../_widgets/dialogs/app_dialog.dart';
import 'set_user_data.dart';

bool isSavedItem(String id) => savedBox.containsKey(id);

void saveItem(String id, bool isSaved) {
  if (isSignedIn()) {
    if (isSaved) {
      savedBox.delete(id);
      syncToCloud(db: 'users', space: liveUser(), parent: 'saved', action: 'd', id: id);
    } else {
      String timestamp = getUniqueId();
      savedBox.put(id, timestamp);
      syncToCloud(
        db: 'users',
        space: liveUser(),
        parent: 'saved',
        action: 'c',
        id: id,
        data: timestamp,
      );
    }
  } else {
    showAppDialog(
      title: 'Sign in to save your favorite articles.',
      actions: [
        ActionButton(isCancel: true),
        ActionButton(
          label: 'Sign in',
          onPressed: () => navigatorState.currentContext!.go('/getstarted'),
        ),
      ],
    );
  }
}
