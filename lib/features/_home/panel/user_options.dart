import 'package:flutter/material.dart';

import '../../../_theme/spacing.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../../pomodoro/sheet.dart';
import '../_helpers/nav.dart';

class UserOptions extends StatelessWidget {
  const UserOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        if (showNavItem(feature.pomodoro)) mph(),
        if (showNavItem(feature.pomodoro))
          AppButton(
            onPressed: () => showPomodoroSheet(),
            tooltip: 'Pomodoro',
            tooltipDirection: AxisDirection.right,
            isSquare: true,
            noStyling: true,
            child: AppIcon(Icons.timer, faded: true),
          ),
        // mph(),
        // NavMenu(),
        mph(),
      ],
    );
  }
}
