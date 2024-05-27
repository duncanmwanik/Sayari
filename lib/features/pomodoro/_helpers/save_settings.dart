import 'package:collection/collection.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../_providers/providers.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/others/toast.dart';
import '../../_tables/_helpers/common.dart';

Future<void> savePomodoroSettings(Map previousPomodoroMap) async {
  try {
    if (!DeepCollectionEquality().equals(previousPomodoroMap, state.pomodoro.pomodoroMap)) {
      Hive.box('${liveTable()}_${feature.pomodoro.t}').put('p', state.pomodoro.pomodoroMap);

      await syncToCloud(
        db: 'tables',
        parentId: liveTable(),
        type: feature.pomodoro.t,
        action: 'c',
        itemId: 'p',
        data: state.pomodoro.pomodoroMap,
      );
    }
  }
  //
  //
  catch (e) {
    showToast(0, 'Could not save settings');
  }
}
