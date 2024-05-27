import 'package:flutter/material.dart';

import '../../../../__styling/spacing.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/others/list_tile.dart';
import '../../../../_widgets/others/text.dart';
import '../../_helpers/checks_table.dart';
import '../admins_sheet.dart';

class TableAdminTile extends StatelessWidget {
  const TableAdminTile({super.key});

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      onTap: () => showAdminsBottomSheet(title: isAdmin() ? 'Manage Admins' : 'Table Admins'),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppIcon(Icons.admin_panel_settings_rounded, size: 18),
          SizedBox(width: smallWidth()),
          Flexible(
              child: AppText(
            text: isAdmin() ? 'Manage Admins' : 'Table Admins',
          )),
        ],
      ),
      trailing: AppIcon(Icons.keyboard_arrow_right_rounded, size: 18),
    );
  }
}
