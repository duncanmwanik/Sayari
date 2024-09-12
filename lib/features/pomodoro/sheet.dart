import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/abcs/buttons/close_button.dart';
import '../../_widgets/abcs/dialogs_sheets/bottom_sheet.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/others/scroll.dart';
import '_w_settings/settings_dialog.dart';
import 'chooser.dart';
import 'counter.dart';

Future<void> showPomodoroSheet() async {
  await showAppBottomSheet(
    isFull: true, showTopDivider: false,
    header: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //
        AppCloseButton(isX: true),
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
      padding: itemPadding(top: true),
      child: NoScrollBars(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              PomodoroChooser(),
              spph(),
              PomodoroCounter(),
              lpph()
              //
            ],
          ),
        ),
      ),
    ),
    //
  );
}
