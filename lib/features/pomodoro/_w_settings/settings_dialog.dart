import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../_helpers/_common/global.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_providers/providers.dart';
import '../../../_widgets/abcs/dialogs_sheets/app_dialog.dart';
import '../../../_widgets/abcs/dialogs_sheets/dialog_buttons.dart';
import '../../../_widgets/others/checkbox.dart';
import '../../../_widgets/others/others/divider.dart';
import '../../../_widgets/others/others/list_tile.dart';
import '../_helpers/save_settings.dart';
import '../_state/pomodoro_provider.dart';
import 'alarm_chooser.dart';
import 'setting.dart';

Future<void> showPomodoroSettingsDialog() async {
  Map previousPomodoroMap = getNewMapFrom(state.pomodoro.pomodoroMap);

  await showAppDialog(
    content: Consumer<PomodoroProvider>(builder: (context, pomodoroProvider, child) {
      bool isAutoPlayOn = pomodoroProvider.pomodoroMap['autoPlay'] == '1';
      bool isAlarmOn = pomodoroProvider.pomodoroMap['alarmOn'] == '1';

      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            //
            PomodoroSetting(type: 'focus'),
            //
            AppDivider(height: largeHeight()),
            //
            PomodoroSetting(type: 'shortBreak'),
            //
            AppDivider(height: largeHeight()),
            //
            PomodoroSetting(type: 'longBreak'),
            //
            AppDivider(height: largeHeight()),
            //
            AppListTile(
              onTap: () => pomodoroProvider.updatePomodoroMap('autoPlay', isAutoPlayOn ? '0' : '1'),
              leading: 'Auto-Repeat',
              trailing: AppCheckBox(
                isChecked: isAutoPlayOn,
                onTap: () => pomodoroProvider.updatePomodoroMap('autoPlay', isAutoPlayOn ? '0' : '1'),
              ),
            ),
            //
            AppDivider(),
            //
            AppListTile(
              onTap: () => pomodoroProvider.updatePomodoroMap('alarmOn', isAlarmOn ? '0' : '1'),
              leading: 'Alarm',
              trailing: AppCheckBox(
                isChecked: isAlarmOn,
                onTap: () => pomodoroProvider.updatePomodoroMap('alarmOn', isAlarmOn ? '0' : '1'),
              ),
            ),
            //
            sph(),
            //
            AlarmChooser(),
            //
            elph(),
            //
          ],
        ),
      );
    }),
    actions: [
      ActionButton(isCancel: true),
      ActionButton(label: 'Save', onPressed: () => popWhatsOnTop(value: true)),
    ],
  ).then((value) {
    if (value == true) {
      savePomodoroSettings(previousPomodoroMap);
    } else {
      state.pomodoro.setPomodoroMap(previousPomodoroMap);
    }
  });
}
