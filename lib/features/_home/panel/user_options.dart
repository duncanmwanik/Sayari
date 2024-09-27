import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../../pomodoro/sheet.dart';
import '../_helpers/nav.dart';
import '../navbars/nav_menu.dart';

class UserOptions extends StatelessWidget {
  const UserOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        // if (showNavOption(feature.explore)) mph(),
        // if (showNavOption(feature.explore))
        //   AppButton(
        //     onPressed: () => showExploreSheet(),
        //     tooltip: 'Explore',
        //     tooltipDirection: AxisDirection.right,
        //     isSquare: true,
        //     noStyling: true,
        //     child: AppIcon(Icons.explore_rounded, faded: true),
        //   ),
        //
        // if (showNavOption(feature.saved)) mph(),
        // if (showNavOption(feature.saved))
        //   AppButton(
        //     onPressed: () => showSavedSheet(),
        //     tooltip: 'Saved',
        //     tooltipDirection: AxisDirection.right,
        //     isSquare: true,
        //     noStyling: true,
        //     child: AppIcon(Icons.bookmark, faded: true),
        //   ),
        //
        if (showNavOption(feature.pomodoro)) mph(),
        if (showNavOption(feature.pomodoro))
          AppButton(
            onPressed: () => showPomodoroSheet(),
            tooltip: 'Pomodoro',
            tooltipDirection: AxisDirection.right,
            isSquare: true,
            noStyling: true,
            child: AppIcon(Icons.timer, faded: true),
          ),
        //
        mph(),
        NavMenu(),
        mph(),
      ],
    );
  }
}
