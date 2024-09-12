import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../__styling/spacing.dart';
import '../../../../_variables/features.dart';
import '../../../../_widgets/abcs/dialogs_sheets/app_dialog.dart';
import '../../../../_widgets/abcs/dialogs_sheets/dialog_buttons.dart';
import '../../../../_widgets/others/others/divider.dart';
import '../../_helpers/common.dart';
import 'notification_item.dart';

Future showSpaceNotificationsDialog() {
  return showAppDialog(
    title: 'Notifications',
    content: ValueListenableBuilder(
        valueListenable: Hive.box('${liveSpace()}_notifications').listenable(),
        builder: (context, box, widget) {
          return ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              //
              NotificationItem(label: feature.space.t, value: box.get(feature.space.t, defaultValue: false), type: feature.space.t),
              //
              AppDivider(height: 0),
              //
              NotificationItem(
                  label: feature.calendar.t, value: box.get(feature.calendar.t, defaultValue: false), type: feature.calendar.t),
              //
              AppDivider(height: 0),
              //
              NotificationItem(label: feature.items.t, value: box.get(feature.items.t, defaultValue: false), type: feature.items.t),
              //
              AppDivider(height: 0),
              //
              NotificationItem(label: feature.chat.t, value: box.get(feature.chat.t, defaultValue: false), type: feature.chat.t),
              //
              msph(),
              //
            ],
          );
        }),
    actions: [
      ActionButton(
        isCancel: true,
      ),
      ActionButton(label: 'Save'),
    ],
  );
}
