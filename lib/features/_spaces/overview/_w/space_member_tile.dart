import 'package:flutter/material.dart';

import '../../../../__styling/spacing.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/others/list_tile.dart';
import '../../../../_widgets/others/text.dart';
import '../../_helpers/checks_space.dart';
import '../members_sheet.dart';

class SpaceAdminTile extends StatelessWidget {
  const SpaceAdminTile({super.key});

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      onTap: () => showAdminsBottomSheet(title: isAdmin() ? 'Manage Admins' : 'Space Admins'),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppIcon(Icons.people, size: 18),
          spw(),
          Flexible(child: AppText(text: 'Members')),
        ],
      ),
      trailing: AppIcon(Icons.keyboard_arrow_right_rounded, size: 18),
    );
  }
}
