import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/helpers.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_providers/common/input.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';
import '../_notes/_helpers/quick_edit.dart';
import '_helpers/helper.dart';
import '_helpers/reminders.dart';
import 'reminder_menu.dart';

class Reminder extends StatelessWidget {
  const Reminder({
    super.key,
    this.reminder,
    this.bgColor,
    this.type,
    this.itemId = '',
    this.subId = '',
    this.isInput = true,
  });

  final String? type;
  final String? reminder;
  final String? bgColor;

  final String itemId;
  final String subId;
  final bool isInput;

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      String reminder_ = reminder ?? input.data['r'] ?? '';
      String type_ = type ?? input.type;

      bool hasPassed = isLive(reminder_);
      bool isInput = itemId.isEmpty;

      return Visibility(
        visible: hasReminder(reminder_),
        child: Padding(
          padding: paddingM('t'),
          child: AppButton(
            menuWidth: 200,
            menuItems: reminderMenu(
              reminder: reminder_,
              onSet: (newReminder) async {
                if (isInput) {
                  input.update('r', newReminder);
                } else {
                  await editItemExtras(type: type_, itemId: itemId, key: 'r', value: newReminder, subId: subId);
                }
              },
              onRemove: () async {
                if (isInput) {
                  input.remove('r');
                } else {
                  await editItemExtras(type: type_, itemId: itemId, subId: subId, key: 'd/r', value: '');
                }
              },
            ),
            smallVerticalPadding: true,
            smallLeftPadding: true,
            color: hasColour(bgColor) ? Colors.white24 : null,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // icon
                AppIcon(Icons.notifications_active, size: 12, faded: hasPassed, bgColor: bgColor),
                tpw(),
                // text
                Flexible(
                  child: FittedBox(
                    child: AppText(size: small, text: formatReminder(reminder_), faded: hasPassed, bgColor: bgColor, isCrossed: hasPassed),
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
