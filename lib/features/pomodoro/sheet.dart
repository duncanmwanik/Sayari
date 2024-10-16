import 'package:flutter/material.dart';

import '../../_theme/helpers.dart';
import '../../_theme/spacing.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/buttons/close.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/others/scroll.dart';
import '../../_widgets/sheets/bottom_sheet.dart';
import '../_notes/types/tasks/quicktasks/quick_tasks.dart';
import 'chooser.dart';
import 'counter.dart';
import 'w_settings/settings_dialog.dart';

Future<void> showPomodoroSheet() async {
  await showAppBottomSheet(
    isFull: true,
    showTopDivider: false,
    showBlur: isDark(),
    header: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // settings
        AppButton(
          onPressed: () => showPomodoroSettingsDialog(),
          tooltip: 'Pomodoro Settings',
          noStyling: true,
          isSquare: true,
          child: AppIcon(Icons.settings_rounded, faded: true),
        ),
        spw(),
        AppCloseButton(),
        //
      ],
    ),
    content: NoScrollBars(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            PomodoroChooser(),
            PomodoroCounter(),
            QuickTasks(),
            //
          ],
        ),
      ),
    ),
    //
  );
}
