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
