import 'package:go_router/go_router.dart';

import '../../../_helpers/_common/global.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_variables/navigation.dart';
import '../../../_widgets/abcs/dialogs_sheets/app_dialog.dart';
import '../../../_widgets/abcs/dialogs_sheets/dialog_buttons.dart';
import 'set_user_data.dart';

bool isSavedItem(String itemId) => savedBox.containsKey(itemId);

void saveItem(String itemId, bool isSaved) {
  if (isSignedIn()) {
    if (isSaved) {
      savedBox.delete(itemId);
      syncToCloud(db: 'users', parentId: liveUser(), type: 'saved', action: 'd', itemId: itemId);
    } else {
      String timestamp = getUniqueId();
      savedBox.put(itemId, timestamp);
      syncToCloud(
        db: 'users',
        parentId: liveUser(),
        type: 'saved',
        action: 'c',
        itemId: itemId,
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
          onPressed: () => navigatorState.currentContext!.go('/welcome'),
        ),
      ],
    );
  }
}
