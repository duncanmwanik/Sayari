import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_helpers/sync/quick_edit.dart';
import '../../_models/item.dart';
import '../../_providers/_providers.dart';
import '../../_providers/input.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/features.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';
import '_helpers/reminders.dart';
import 'reminder_menu.dart';

class Reminder extends StatelessWidget {
  const Reminder({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    bool isInput = !item.exists();

    return Consumer<InputProvider>(builder: (context, input, child) {
      bool hasPassed = item.hasReminderPassed();

      return Visibility(
        visible: item.hasReminder(),
        child: Padding(
          padding: padM('t'),
          child: AppButton(
            menuWidth: 200,
            menuItems: reminderMenu(
              reminder: item.reminder(),
              onSet: (newReminder) async {
                if (isInput) {
                  state.input.update('r', newReminder);
                } else {
                  await quickEdit(parent: feature.notes, id: item.id, key: 'r', value: newReminder, sid: item.sid);
                }
              },
              onRemove: () async {
                if (isInput) {
                  state.input.remove('r');
                } else {
                  await quickEdit(parent: feature.notes, id: item.id, sid: item.sid, key: 'd/r', value: '');
                }
              },
            ),
            svp: true,
            slp: true,
            srp: true,
            showBorder: item.hasColor(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // icon
                AppIcon(Icons.notifications_active, size: 12, faded: hasPassed, bgColor: item.color()),
                tpw(),
                // text
                Flexible(
                  child: AppText(
                    size: tiny,
                    text: formatReminder(item.reminder()),
                    faded: true,
                    bgColor: item.color(),
                    isCrossed: hasPassed,
                  ),
                ),
                //
              ],
            ),
          ),
        ),
      );
    });
  }
}
