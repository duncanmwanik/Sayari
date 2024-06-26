import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_helpers/_common/global.dart';
import '../../../../_helpers/_common/navigation.dart';
import '../../../../_providers/common/input.dart';
import '../../../../_widgets/abcs/buttons/buttons.dart';
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
            children: [
              // Icon
              AppIcon(Icons.notification_add, faded: true, size: 18),
              spw(),
              // Add Button
              AppButton(
                  onPressed: () async {
                    hideKeyboard();
                    remindersList.add('30.m');
                    input.update(action: 'add', key: 'r', value: getJoinedList(remindersList));
                  },
                  child: Row(
                    children: [
                      AppIcon(Icons.add_rounded, size: 16),
                      tpw(),
                      AppText(text: 'Add Reminder'),
                    ],
                  )),
              //
            ],
          ),
          //
          //
          kIsWeb ? sph() : tph(),
          //
          // Reminder List
          //
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: remindersList.isNotEmpty
                ? Column(
                    children: List.generate(remindersList.length, (index) {
                    String reminder = remindersList[index];

                    return ReminderItem(reminder: reminder);
                  }))
                : Padding(
                    padding: itemPaddingMedium(left: true, top: true),
                    child: AppText(size: small, text: 'No reminders set', faded: true),
                  ),
          ),
          //
          //
        ],
      );
    });
  }
}
