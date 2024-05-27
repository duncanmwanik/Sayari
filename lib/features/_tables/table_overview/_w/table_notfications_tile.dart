import 'package:flutter/material.dart';

import '../../../../__styling/spacing.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/others/list_tile.dart';
import '../../../../_widgets/others/text.dart';
import 'notifications.dart';

class TableNotificationsTile extends StatelessWidget {
  const TableNotificationsTile({super.key, required this.tableName});

  final String tableName;

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      onTap: () => showTableNotificationsDialog(),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppIcon(Icons.notifications_active_rounded, size: 18),
          spw(),
          Flexible(child: AppText(text: 'Table Notifications')),
        ],
      ),
      trailing: AppIcon(Icons.keyboard_arrow_right_rounded, size: 18),
    );
  }
}
