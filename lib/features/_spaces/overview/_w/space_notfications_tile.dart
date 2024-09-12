import 'package:flutter/material.dart';

import '../../../../__styling/spacing.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/others/list_tile.dart';
import '../../../../_widgets/others/text.dart';
import 'notifications.dart';

class SpaceNotificationsTile extends StatelessWidget {
  const SpaceNotificationsTile({super.key, required this.spaceName});

  final String spaceName;

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      onTap: () => showSpaceNotificationsDialog(),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppIcon(Icons.notifications_active_rounded, size: 18),
          spw(),
          Flexible(child: AppText(text: 'Notifications')),
        ],
      ),
      trailing: AppIcon(Icons.keyboard_arrow_right_rounded, size: 18),
    );
  }
}
