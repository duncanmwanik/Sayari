import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../__styling/styler.dart';
import '../../__styling/variables.dart';
import '../../_helpers/navigation.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/others/scroll.dart';
import '../../_widgets/sheets/bottom_sheet.dart';
import 'chooser.dart';
import 'counter.dart';
import 'w_settings/settings_dialog.dart';

Future<void> showPomodoroSheet() async {
  await showAppBottomSheet(
    isFull: true,
    showTopDivider: false,
    showBlur: true,
    header: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //
        AppButton(
          onPressed: () => popWhatsOnTop(),
          noStyling: true,
          isSquare: true,
          child: AppIcon(closeIcon, color: AppColors.darkTextFaded),
        ),
        // settings
        AppButton(
          onPressed: () => showPomodoroSettingsDialog(),
          noStyling: true,
          isSquare: true,
          child: AppIcon(Icons.settings_rounded, color: AppColors.darkTextFaded),
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
