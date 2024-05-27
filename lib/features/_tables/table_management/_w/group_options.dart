import 'package:flutter/material.dart';

import '../../../../_helpers/user/user_actions.dart';
import '../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../_widgets/abcs/menu/menu_item.dart';
import '../../../../_widgets/others/icons.dart';

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
          iconData: Icons.folder_delete_rounded,
          onTap: () => deleteGroup(groupName),
        ),
        //
      ],
      noStyling: true,isSquare: true,
      child: AppIcon(Icons.more_vert, faded: true, size: 18),
    );
  }
}
