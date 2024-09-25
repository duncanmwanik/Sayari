import 'package:flutter/material.dart';

import '../../../__styling/breakpoints.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../../../_widgets/others/icons.dart';
import '../../explore/explore_sheet.dart';
import '../../pomodoro/sheet.dart';
import '../../saved/saved_sheet.dart';
import '../_helpers/change_view.dart';
import '../_helpers/nav.dart';
import 'pinned_settings.dart';

class NavMenu extends StatelessWidget {
  const NavMenu({super.key});

  @override
  Widget build(BuildContext context) {
    bool showWorkspace = !showNavOption(feature.chat);
    bool showUser =
        !showNavOption(feature.explore) || !showNavOption(feature.saved) || (!showNavOption(feature.pomodoro) || !showPanelOptions());

    return AppButton(
      menuItems: [
        // workspace
        if (showWorkspace) MenuItem(label: 'Workspace', faded: true),
        if (!showNavOption(feature.chat)) MenuItem(label: 'Chat', leading: Icons.message_rounded, onTap: () => goToView(feature.chat)),
        //
        //
        if (showWorkspace) menuDivider(),
        // user
        if (showUser) MenuItem(label: 'User', faded: true),
        //
        if (!showNavOption(feature.explore)) MenuItem(label: 'Explore', leading: Icons.explore, onTap: () => showExploreSheet()),
        //
        if (!showNavOption(feature.saved) || !showPanelOptions())
          MenuItem(label: 'Saved', leading: Icons.bookmark, onTap: () => showSavedSheet()),
        //
        if (!showNavOption(feature.pomodoro) || !showPanelOptions())
          MenuItem(label: 'Pomodoro', leading: Icons.timer, onTap: () => showPomodoroSheet()),
        //
        if (showWorkspace || showUser) menuDivider(),
        //
        MenuItem(label: 'Customize', leading: Icons.tune, menuItems: pinnedNavOptions()),
        //
      ],
      tooltip: 'Options',
      noStyling: true,
      tooltipDirection: isSmallPC() ? AxisDirection.right : AxisDirection.up,
      padding: EdgeInsets.all(isSmallPC() ? 8 : 12),
      child: SizedBox(
        width: (isSmallPC() ? 16 : 18),
        height: (isSmallPC() ? 16 : 18),
        child: AppIcon(Icons.menu, size: (isSmallPC() ? 16 : 18), faded: true),
      ),
    );
  }
}
