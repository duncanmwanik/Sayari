import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../__styling/spacing.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../../explore/explore_sheet.dart';
import '../../pomodoro/sheet.dart';
import '../../saved/saved_sheet.dart';
import '../_helpers/nav.dart';
import '../panel/toggle.dart';
import 'nav_menu.dart';

class UserOptions extends StatelessWidget {
  const UserOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        mph(),
        PanelToggle(),
        //
        if (showNavOption(feature.explore.t)) sph(),
        if (showNavOption(feature.explore.t))
          AppButton(
            onPressed: () => showExploreSheet(),
            tooltip: 'Explore',
            tooltipDirection: AxisDirection.right,
            isSquare: true,
            noStyling: true,
            child: AppIcon(Icons.explore_rounded, faded: true),
          ),
        //
        if (showNavOption(feature.saved.t)) mph(),
        if (showNavOption(feature.saved.t))
          AppButton(
            onPressed: () => showSavedSheet(),
            tooltip: 'Saved',
            tooltipDirection: AxisDirection.right,
            isSquare: true,
            noStyling: true,
            child: AppIcon(Icons.bookmark, faded: true),
          ),
        //
        if (showNavOption(feature.pomodoro.t)) mph(),
        if (showNavOption(feature.pomodoro.t))
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
        //
        mph(),
        AppButton(
          // onPressed: () => showToast(1, 'This is a nice app '),
          onPressed: () => context.go('/test/Guide'),
          tooltip: 'Guide',
          tooltipDirection: AxisDirection.right,
          isSquare: true,
          noStyling: true,
          child: AppIcon(Icons.help, faded: true),
        ),
        //
        mph(),
      ],
    );
  }
}
