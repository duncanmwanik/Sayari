import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../__styling/spacing.dart';
import '../../../../_helpers/global.dart';
import '../../../../_providers/input.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/forms/numeric.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../_notes/w/picker_type.dart';
import '../../../reminders/_helpers/reminders.dart';

class ReminderItem extends StatelessWidget {
  const ReminderItem({super.key, required this.reminder});

  final String reminder;

  @override
  Widget build(BuildContext context) {
    String reminderNo = reminder.split('.')[0];
    String reminderPeriod = reminder.split('.')[1];

    return Consumer<InputProvider>(builder: (context, input, child) {
      return Padding(
        padding: EdgeInsets.only(top: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // reminder Value
            Flexible(
              child: SizedBox(
                width: 40,
                child: NumericFormInput(
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      String newReminder = '${value.trim()}.$reminderPeriod';
                      List remindersList = splitList((input.item.data['r'] ?? ''));
                      remindersList.remove(reminder);
                      remindersList.add(newReminder);
                      input.update('r', joinList(remindersList));
                    }
                  },
                  hintText: 'No.',
                  initialValue: reminderNo,
                  maxLength: 2,
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
            //
            tpw(),
            // reminder period
            Flexible(
              child: AppTypePicker(
                onSelect: (chosenKey, chosenValue) {
                  String newReminder = '$reminderNo.$chosenValue';
                  List remindersList = splitList((input.item.data['r'] ?? ''));
                  remindersList.remove(reminder);
                  remindersList.add(newReminder);
                  input.update('r', joinList(remindersList));
                },
                initial: reminderPeriodsMap[reminderPeriod],
                typeEntries: {'minutes': 'm', 'hours': 'h', 'days': 'd', 'weeks': 'w'},
                smallVerticalPadding: true,
              ),
            ),
            // remove reminder
            tpw(),
            AppButton(
              onPressed: () {
                List remindersList = splitList((input.item.data['r'] ?? ''));
                remindersList.remove(reminder);
                if (remindersList.isEmpty) {
                  input.remove('r');
                } else {
                  input.update('r', joinList(remindersList));
                }
              },
              noStyling: true,
              isRound: true,
              child: AppIcon(Icons.close, size: 14),
            ),
            //
          ],
        ),
      );
    });
  }
}
