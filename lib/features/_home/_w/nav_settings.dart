import 'package:flutter/material.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/variables.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import 'navbar_options.dart';

class NavSettings extends StatelessWidget {
  const NavSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      menuItems: [
        //
        NavOptionToggle(type: feature.notes.t, isDefault: true),
        NavOptionToggle(type: feature.notes.t, isDefault: true),
        NavOptionToggle(type: feature.explore.t, isDefault: true),
        NavOptionToggle(type: feature.chat.t),
        if (isSmallPC()) NavOptionToggle(type: feature.code.t),
        //
      ],
      tooltip: 'Navbar Options',
      noStyling: true,
      color: styler.appColor(2),
      borderRadius: borderRadiusSmall,
      padding: EdgeInsets.all(showVertNav() ? 8 : 12),
      child: SizedBox(
        width: (showVertNav() ? 16 : 18),
        height: (showVertNav() ? 16 : 18),
        child: AppIcon(moreIcon, size: (showVertNav() ? 16 : 18), faded: true),
      ),
    );
  }
}
