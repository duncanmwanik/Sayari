import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_helpers/sync/quick_edit.dart';
import '../../_providers/input.dart';
import '../../_theme/helpers.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/features.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';
import '_helpers/helper.dart';
import '_helpers/reminders.dart';
import 'reminder_menu.dart';

class Reminder extends StatelessWidget {
  const Reminder({
    super.key,
    this.reminder,
    this.bgColor,
    this.id = '',
    this.sid = '',
    this.isInput = true,
  });

  final String? reminder;
  final String? bgColor;

  final String id;
  final String sid;
  final bool isInput;

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      String reminder_ = reminder ?? input.item.data['r'] ?? '';

      bool hasPassed = isLive(reminder_);
      bool isInput = id.isEmpty;

      return Visibility(
        visible: hasReminder(reminder_),
        child: Padding(
          padding: padM('t'),
          child: AppButton(
            menuWidth: 200,
            menuItems: reminderMenu(
              reminder: reminder_,
              onSet: (newReminder) async {
                if (isInput) {
                  input.update('r', newReminder);
                } else {
                  await quickEdit(parent: feature.notes, id: id, key: 'r', value: newReminder, sid: sid);
                }
              },
              onRemove: () async {
                if (isInput) {
                  input.remove('r');
                } else {
                  await quickEdit(parent: feature.notes, id: id, sid: sid, key: 'd/r', value: '');
                }
              },
            ),
            svp: true,
            slp: true,
            srp: true,
            showBorder: hasColour(bgColor),
            color: hasColour(bgColor) ? Colors.white24 : null,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // icon
                AppIcon(Icons.notifications_active, size: 12, faded: hasPassed, bgColor: bgColor),
                tpw(),
                // text
                Flexible(
                  child: AppText(
                    size: tiny,
                    text: formatReminder(reminder_),
                    faded: true,
                    bgColor: bgColor,
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
