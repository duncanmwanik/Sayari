import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../_helpers/_common/global.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_providers/_providers.dart';
import '../../../_widgets/buttons/action.dart';
import '../../../_widgets/dialogs/app_dialog.dart';
import '../../../_widgets/others/checkbox.dart';
import '../../../_widgets/others/others/divider.dart';
import '../../../_widgets/others/others/list_tile.dart';
import '../_helpers/save_settings.dart';
import '../state/pomodoro.dart';
import 'alarm_chooser.dart';
import 'setting.dart';

Future<void> showPomodoroSettingsDialog() async {
  Map previousdata = getNewMapFrom(state.pomodoro.data);

  await showAppDialog(
    title: 'Pomodoro Settings',
    content: Consumer<PomodoroProvider>(builder: (context, pomodoroProvider, child) {
      bool isAutoPlayOn = pomodoroProvider.data['ap'] == '1';
      bool isAlarmOn = pomodoroProvider.data['ao'] == '1';

      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            PomodoroSetting(type: 'f'),
            //
            tph(), AppDivider(height: smallHeight()),
            //
            PomodoroSetting(type: 's'),
            //
            tph(), AppDivider(height: smallHeight()),
            //
            PomodoroSetting(type: 'l'),
            //
            tph(), AppDivider(height: smallHeight()),
            //
            AppListTile(
              onTap: () => pomodoroProvider.updatedata('ap', isAutoPlayOn ? '0' : '1'),
              leading: 'Auto-Repeat',
              trailing: AppCheckBox(
                isChecked: isAutoPlayOn,
                onTap: () => pomodoroProvider.updatedata('ap', isAutoPlayOn ? '0' : '1'),
              ),
            ),
            //
            AppDivider(height: smallHeight()),
            //
            AppListTile(
              onTap: () => pomodoroProvider.updatedata('ao', isAlarmOn ? '0' : '1'),
              leading: 'Alarm',
              trailing: AppCheckBox(
                isChecked: isAlarmOn,
                onTap: () => pomodoroProvider.updatedata('ao', isAlarmOn ? '0' : '1'),
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
      savePomodoroSettings(previousdata);
    } else {
      state.pomodoro.setdata(previousdata);
    }
  });
}
