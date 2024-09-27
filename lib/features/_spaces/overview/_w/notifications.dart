import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../__styling/spacing.dart';
import '../../../../_services/hive/get_data.dart';
import '../../../../_variables/features.dart';
import '../../../../_widgets/buttons/action.dart';
import '../../../../_widgets/dialogs/app_dialog.dart';
import '../../../../_widgets/others/others/divider.dart';
import 'notification_item.dart';

Future showSpaceNotificationsDialog() {
  return showAppDialog(
    title: 'Notifications',
    content: ValueListenableBuilder(
        valueListenable: storage('notifications').listenable(),
        builder: (context, box, widget) {
          return ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              //
              NotificationItem(label: feature.space, value: box.get(feature.space, defaultValue: false), type: feature.space),
              //
              AppDivider(),
              //
              NotificationItem(label: feature.calendar, value: box.get(feature.calendar, defaultValue: false), type: feature.calendar),
              //
              AppDivider(),
              //
              NotificationItem(label: feature.notes, value: box.get(feature.notes, defaultValue: false), type: feature.notes),
              //
              AppDivider(),
              //
              NotificationItem(label: feature.chat, value: box.get(feature.chat, defaultValue: false), type: feature.chat),
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
