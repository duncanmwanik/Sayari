import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../__styling/spacing.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../../explore/explore_sheet.dart';
import '../../saved/saved_sheet.dart';
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
        AppButton(
          onPressed: () => showExploreSheet(),
          tooltip: 'Explore',
          tooltipDirection: AxisDirection.right,
          isSquare: true,
          noStyling: true,
          child: AppIcon(Icons.explore_rounded, faded: true),
        ),
        mph(),
        AppButton(
          onPressed: () => showSavedSheet(),
          tooltip: 'Saved',
          tooltipDirection: AxisDirection.right,
          isSquare: true,
          noStyling: true,
          child: AppIcon(Icons.bookmark, faded: true),
        ),
        mph(),
        NavMenu(),
        mph(),
        AppButton(
          // onPressed: () => showToast(1, 'This is a nice app '),
          onPressed: () => context.go('/test/Guide'),
          tooltip: 'Help',
          tooltipDirection: AxisDirection.right,
          isSquare: true,
          noStyling: true,
          child: AppIcon(Icons.help, faded: true),
        ),
        mph(),
      ],
    );
  }
}
