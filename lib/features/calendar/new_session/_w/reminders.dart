import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_helpers/_common/global.dart';
import '../../../../_helpers/_common/navigation.dart';
import '../../../../_providers/common/input.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/text.dart';
import 'reminder_item.dart';

class Reminders extends StatelessWidget {
  const Reminders({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      List remindersList = getSplitList((input.data['r']));

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Padding(padding: paddingS('t'), child: AppIcon(Icons.notification_add, faded: true, size: normal)),
              mpw(),
              //
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // add
                    AppButton(
                        onPressed: () async {
                          hideKeyboard();
                          remindersList.add('30.m');
                          input.update('r', getJoinedList(remindersList));
                        },
                        noStyling: true,
                        showBorder: true,
                        smallLeftPadding: true,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppIcon(Icons.add_rounded, size: 16),
                            tpw(),
                            AppText(text: 'Add Reminder'),
                          ],
                        )),
                    // reminder list
                    remindersList.isNotEmpty
                        ? Column(
                            children: List.generate(remindersList.length, (index) {
                            String reminder = remindersList[index];
                            return ReminderItem(reminder: reminder);
                          }))
                        : Padding(
                            padding: paddingM('lt'),
                            child: AppText(size: small, text: 'No reminders set', faded: true),
                          ),
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
