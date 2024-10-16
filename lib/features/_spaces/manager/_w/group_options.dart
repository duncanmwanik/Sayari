import 'package:flutter/material.dart';

import '../../../../_theme/variables.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/menu/menu_item.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../user/_helpers/actions.dart';

class GroupOptions extends StatelessWidget {
  const GroupOptions({super.key, required this.groupName});

  final String groupName;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      tooltip: 'Options',
      menuItems: [
        //
        MenuItem(
          label: 'Delete Group',
          leading: Icons.folder_delete_rounded,
          onTap: () => deleteGroup(groupName),
        ),
        //
      ],
      noStyling: true,
      isSquare: true,
      child: AppIcon(moreIcon, faded: true, size: 18),
    );
  }
}
