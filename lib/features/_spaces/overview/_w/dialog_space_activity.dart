import 'package:flutter/material.dart';

import '../../../../_services/activity/activity_helper.dart';
import '../../../../_widgets/dialogs/app_dialog.dart';
import '../../../../_widgets/dialogs/dialog_buttons.dart';
import '../../../../_widgets/dialogs/dialog_option_button.dart';

Future showSpaceActivityDialog(String activityId) async {
  await showAppDialog(title: 'Delete ativity?', actions: [
    ActionButton(
      isCancel: true,
    ),
    DialogOptionButton(
      label: 'Delete',
      iconData: Icons.delete,
      onTap: () => deleteActivity(activityId),
    ),
  ]);
}
