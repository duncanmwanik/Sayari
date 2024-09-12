import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../reminders/_helpers/helper.dart';

class SessionReminders extends StatelessWidget {
  const SessionReminders({super.key, required this.reminderString});

  final String reminderString;

  @override
  Widget build(BuildContext context) {
    List reminderList = getReminderList(reminderString);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // reminder icon
        AppIcon(Icons.notifications_outlined, size: normal, faded: true),
        //
        spw(),
        // reminder list
        Flexible(
          child: Wrap(
            spacing: smallWidth(),
            runSpacing: tinyWidth(),
            children: List.generate(
                reminderList.length,
                (index) => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (index != 0) AppIcon(Icons.lens, size: 5, faded: true),
                        if (index != 0) spw(),
                        Flexible(child: AppText(text: reminderList[index], fontWeight: FontWeight.w400, faded: true)),
                      ],
                    )),
          ),
        ),
      ],
    );
  }
}
