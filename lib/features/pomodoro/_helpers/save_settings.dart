import 'dart:convert';

import 'package:collection/collection.dart';

import '../../../_providers/_providers.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/others/toast.dart';
import '../../user/_helpers/helpers.dart';

Future<void> savePomodoroSettings(Map previousdata) async {
  try {
    if (!DeepCollectionEquality().equals(previousdata, state.pomodoro.data)) {
      state.pomodoro.reset();
      settingBox.put('pm', jsonEncode(state.pomodoro.data));
      syncToCloud(
        db: 'users',
        space: liveUser(),
        parent: 'settings',
        id: 'pm',
        data: jsonEncode(state.pomodoro.data),
        action: 'c',
      );
    }
  } catch (e) {
    showToast(0, 'Could not save settings.');
  }
}
