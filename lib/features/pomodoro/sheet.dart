import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/buttons/close.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/others/scroll.dart';
import '../../_widgets/sheets/bottom_sheet.dart';
import '_w_settings/settings_dialog.dart';
import 'chooser.dart';
import 'counter.dart';

Future<void> showPomodoroSheet() async {
  await showAppBottomSheet(
    isFull: true,
    showTopDivider: false,
    showBlur: true,
    header: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //
        AppCloseButton(),
        // settings
        AppButton(
          onPressed: () => showPomodoroSettingsDialog(),
          noStyling: true,
          isSquare: true,
          child: AppIcon(Icons.settings_rounded, faded: true),
        ),
        //
      ],
    ),
    content: Padding(
      padding: padding(s: 't'),
      child: NoScrollBars(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              PomodoroChooser(),
              spph(),
              PomodoroCounter(),
              spph()
              //
            ],
          ),
        ),
      ),
    ),
    //
  );
}
