import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_helpers/_common/global.dart';
import '../../../../_providers/common/input.dart';
import '../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../_widgets/items/picker_type.dart';
import '../../../../_widgets/others/forms/numeric.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../reminders/_helpers/reminders.dart';

class ReminderItem extends StatefulWidget {
  const ReminderItem({super.key, required this.reminder});

  final String reminder;

  @override
  State<ReminderItem> createState() => _ReminderItemState();
}

class _ReminderItemState extends State<ReminderItem> {
  @override
  Widget build(BuildContext context) {
    String reminderNo = widget.reminder.split('.')[0];
    String reminderPeriod = widget.reminder.split('.')[1];

    return Consumer<InputProvider>(builder: (context, input, child) {
      return Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            // reminder Value
            //
            Flexible(
              child: Container(
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadiusMedium),
                ),
                child: NumericFormInput(
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      String newReminder = '${value.trim()}.$reminderPeriod';
                      List remindersList = getSplitList((input.data['r'] ?? ''));
                      remindersList.remove(widget.reminder);
                      remindersList.add(newReminder);
                      input.update(action: 'add', key: 'r', value: getJoinedList(remindersList));
                    }
                  },
                  hintText: 'No.',
                  initialValue: reminderNo,
                  maxLength: 2,
                ),
              ),
            ),
            //
            spw(),
            //
            // reminder period
            //
            Flexible(
              child: AppTypePicker(
                initial: reminderPeriodsMap[reminderPeriod],
                typeEntries: {'minutes': 'm', 'hours': 'h', 'days': 'd', 'weeks': 'w'},
                onSelect: (chosenKey, chosenValue) {
                  String newReminder = '$reminderNo.$chosenValue';
                  List remindersList = getSplitList((input.data['r'] ?? ''));
                  remindersList.remove(widget.reminder);
                  remindersList.add(newReminder);
                  input.update(action: 'add', key: 'r', value: getJoinedList(remindersList));
                },
                smallVerticalPadding: true,
              ),
            ),
            //
            // remove reminder
            //
            AppButton(
              onPressed: () {
                List remindersList = getSplitList((input.data['r'] ?? ''));
                remindersList.remove(widget.reminder);
                if (remindersList.isEmpty) {
                  input.update(action: 'remove', key: 'r');
                } else {
                  input.update(action: 'add', key: 'r', value: getJoinedList(remindersList));
                }
              },
              noStyling: true,
              child: AppIcon(
                Icons.close,
                size: 14,
              ),
            ),
            //
          ],
        ),
      );
    });
  }
}
