import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_helpers/global.dart';
import '../../../../_helpers/navigation.dart';
import '../../../../_providers/input.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_theme/variables.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/text.dart';
import 'reminder_item.dart';

class Reminders extends StatelessWidget {
  const Reminders({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      List remindersList = splitList((input.item.data['r']));

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Padding(padding: pad(c: 't6'), child: AppIcon(Icons.notification_add, faded: true, size: normal)),
              mpw(),
              //
              Expanded(
                child: Wrap(
                  spacing: smallWidth(),
                  runSpacing: smallWidth(),
                  children: [
                    // reminders
                    for (String reminder in remindersList) ReminderItem(reminder: reminder),
                    // add
                    AppButton(
                        onPressed: () async {
                          hideKeyboard();
                          remindersList.add('30.m');
                          input.update('r', joinList(remindersList));
                        },
                        isSquare: true,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppIcon(Icons.notification_add, size: 16),
                            if (remindersList.isEmpty) spw(),
                            if (remindersList.isEmpty) AppText(text: 'Add Reminder'),
                          ],
                        )),
                    //
                  ],
                ),
              ),
              //
            ],
          ),
          //
        ],
      );
    });
  }
}
