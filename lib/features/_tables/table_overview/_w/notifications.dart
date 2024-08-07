import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../__styling/spacing.dart';
import '../../../../_variables/features.dart';
import '../../../../_widgets/abcs/dialogs_sheets/app_dialog.dart';
import '../../../../_widgets/abcs/dialogs_sheets/dialog_buttons.dart';
import '../../../../_widgets/others/others/divider.dart';
import '../../_helpers/common.dart';
import 'notification_item.dart';

Future showTableNotificationsDialog() {
  return showAppDialog(
    title: 'Notifications',
    content: ValueListenableBuilder(
        valueListenable: Hive.box('${liveTable()}_notifications').listenable(),
        builder: (context, box, widget) {
          return ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              //
              NotificationItem(
                  label: feature.table.t, value: box.get(feature.table.t, defaultValue: false), type: feature.table.t),
              //
              AppDivider(height: 0),
              //
              NotificationItem(
                  label: feature.sessions.t,
                  value: box.get(feature.sessions.t, defaultValue: false),
                  type: feature.sessions.t),
              //
              AppDivider(height: 0),
              //
              NotificationItem(
                  label: feature.notes.t, value: box.get(feature.notes.t, defaultValue: false), type: feature.notes.t),
              //
              AppDivider(height: 0),
              //
              NotificationItem(
                  label: feature.chat.t, value: box.get(feature.chat.t, defaultValue: false), type: feature.chat.t),
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
