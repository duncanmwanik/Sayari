import 'package:flutter/material.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/abcs/menu/menu_item.dart';
import '../../../_widgets/others/icons.dart';
import '../../explore/explore_sheet.dart';
import '../../saved/saved_sheet.dart';
import '../_helpers/change_view.dart';
import '../_helpers/nav.dart';
import 'pinned_settings.dart';

class NavMenu extends StatelessWidget {
  const NavMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      menuItems: [
        //
        if (!showNavOption(feature.chat.t))
          MenuItem(
            label: 'Chat',
            leading: Icons.message_rounded,
            onTap: () => goToView(feature.chat.t),
          ),
        //
        if (!showNavOption(feature.code.t))
          MenuItem(
            label: 'Code',
            leading: Icons.code,
            onTap: () => goToView(feature.code.t),
          ),
        //
        if (!showNavOption(feature.chat.t) || !showNavOption(feature.chat.t)) PopupMenuDivider(height: smallHeight()),
        //
        if (!showPanelOptions() && !showNavOption(feature.explore.t))
          MenuItem(
            label: 'Explore',
            leading: Icons.explore,
            onTap: () => showExploreSheet(),
          ),
        //
        if (!showPanelOptions())
          MenuItem(
            label: 'Saved',
            leading: Icons.bookmark,
            onTap: () => showSavedSheet(),
          ),
        //
        if (!showPanelOptions()) PopupMenuDivider(height: smallHeight()),
        //
        MenuItem(
          label: 'Customize',
          leading: Icons.edit,
          menuItems: pinnedNavOptions(),
        ),
        //
      ],
      tooltip: 'Options',
      tooltipDirection: isSmallPC() ? AxisDirection.right : AxisDirection.up,
      noStyling: true,
      color: styler.appColor(2),
      borderRadius: borderRadiusSmall,
      padding: EdgeInsets.all(isSmallPC() ? 8 : 12),
      child: SizedBox(
        width: (isSmallPC() ? 16 : 18),
        height: (isSmallPC() ? 16 : 18),
        child: AppIcon(moreIcon, size: (isSmallPC() ? 16 : 18), faded: true),
      ),
    );
  }
}
