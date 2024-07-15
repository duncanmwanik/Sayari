import 'package:flutter/material.dart';

import '../../../__styling/variables.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/abcs/menu/menu_item.dart';
import '../../../_widgets/others/icons.dart';

class NavSettings extends StatelessWidget {
  const NavSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      menuItems: [
        //
        // unpinned items here
        //
        MenuItem(
          label: 'Edit Pinned',
          iconData: Icons.edit,
          onTap: () {},
        )
        //
      ],
      noStyling: true,
      isSquare: true,
      tooltip: 'More Options',
      tooltipDirection: AxisDirection.left,
      child: AppIcon(moreIcon, faded: true),
    );
  }
}
