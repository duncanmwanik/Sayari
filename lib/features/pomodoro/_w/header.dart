import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/abcs/buttons/close_button.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../_w_settings/settings_dialog.dart';

class PomodoroHeader extends StatelessWidget {
  const PomodoroHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //
        Expanded(
          child: Row(
            children: [
              AppCloseButton(),
              spw(),
              AppText(text: 'Pomodoro', size: normal, fontWeight: FontWeight.w700),
            ],
          ),
        ),
        //
        spw(),
        // setting button
        AppButton(
          onPressed: () => showPomodoroSettingsDialog(),
          noStyling: true,
          isSquare: true,
          child: AppIcon(Icons.settings_rounded, faded: true),
        ),
        //
      ],
    );
  }
}
