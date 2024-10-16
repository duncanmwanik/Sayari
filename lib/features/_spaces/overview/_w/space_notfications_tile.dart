import 'package:flutter/material.dart';

import '../../../../_widgets/buttons/button.dart';
import 'notifications.dart';

class SpaceNotificationsTile extends StatelessWidget {
  const SpaceNotificationsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onPressed: () => showSpaceNotificationsDialog(),
      leading: Icons.notifications_active_rounded,
      content: 'Notifications',
      trailing: Icons.keyboard_arrow_right_rounded,
    );
  }
}
