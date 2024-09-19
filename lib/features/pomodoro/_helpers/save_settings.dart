import 'dart:convert';

import 'package:collection/collection.dart';

import '../../../_providers/_providers.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/others/toast.dart';
import '../../user/_helpers/set_user_data.dart';

Future<void> savePomodoroSettings(Map previousdata) async {
  try {
    if (!DeepCollectionEquality().equals(previousdata, state.pomodoro.data)) {
      state.pomodoro.reset();
      settingBox.put('pm', jsonEncode(state.pomodoro.data));

      syncToCloud(
        db: 'users',
        parentId: liveUser(),
        type: 'settings',
        action: 'c',
        itemId: 'pm',
        data: jsonEncode(state.pomodoro.data),
      );
    }
  }
  //
  catch (e) {
    showToast(0, 'Could not save settings.');
  }
}
