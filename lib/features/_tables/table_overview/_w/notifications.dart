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
                  label: feature.lists.t, value: box.get(feature.lists.t, defaultValue: false), type: feature.lists.t),
              //
              AppDivider(height: 0),
              //
              NotificationItem(
                  label: feature.finances.t,
                  value: box.get(feature.finances.t, defaultValue: false),
                  type: feature.finances.t),
              //
              AppDivider(height: 0),
              //
              NotificationItem(
                  label: feature.chat.t, value: box.get(feature.chat.t, defaultValue: false), type: feature.chat.t),
              //
              AppDivider(height: 0),
              //
              NotificationItem(
                  label: feature.pomodoro.t,
                  value: box.get(feature.pomodoro.t, defaultValue: false),
                  type: feature.pomodoro.t),
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
