import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_helpers/_common/global.dart';
import '../../../_providers/input.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/color.dart';
import '../../../_widgets/others/color_menu.dart';
import '../../../_widgets/others/icons.dart';
import '../../files/_helpers/upload.dart';
import '../../labels/menu.dart';
import '../../reminders/reminder_menu.dart';
import '../finance/graphs_sheet.dart';
import '../habits/header.dart';
import 'input_actions_more.dart';

class CommonInputActions extends StatelessWidget {
  const CommonInputActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      String? reminder = input.data['r'];
      String? bgColor = input.data['c'];
      bool isPinned = input.data['p'] == '1';

      return Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          //
          if (input.isHabit()) spw(),
          if (input.isHabit()) HabitHeader(),
          //
          if (input.isFinance()) spw(),
          if (input.isFinance())
            AppButton(
              onPressed: () => showFinanceGraphsBottomSheet(),
              tooltip: 'View Graphs',
              noStyling: true,
              isSquare: true,
              child: AppIcon(Icons.insert_chart_outlined_rounded, faded: true),
            ),
          //
          spw(),
          AppButton(
            onPressed: () => input.update('p', isPinned ? '0' : '1'),
            tooltip: isPinned ? 'UnPin' : 'Unpin',
            noStyling: true,
            isSquare: true,
            child: AppIcon(isPinned ? pinIcon : unpinIcon, faded: true),
          ),
          //
          spw(),
          AppButton(
            tooltip: 'Reminder',
            menuWidth: 200,
            menuItems: reminderMenu(
              reminder: reminder,
              onSet: (newReminder) => input.update('r', newReminder),
              onRemove: () => input.remove('r'),
            ),
            noStyling: true,
            isSquare: true,
            child: AppIcon(Icons.notifications_none, faded: true),
          ),
          //
          spw(),
          AppButton(
            menuItems: labelsMenu(
              isSelection: true,
              alreadySelected: getSplitList(input.data['l']),
              onDone: (newLabels) => input.update('l', newLabels.join('|')),
            ),
            tooltip: 'Label',
            noStyling: true,
            isSquare: true,
            child: AppIcon(labelIcon, faded: true),
          ),
          //
          spw(),
          ColorButton(
            menuItems: colorMenu(
              selectedColor: bgColor,
              onSelect: (newColor) => input.update('c', newColor),
            ),
            bgColor: bgColor,
          ),
          //
          spw(),
          AppButton(
            onPressed: () async => await getFilesToUpload(),
            tooltip: 'Attach File',
            noStyling: true,
            isSquare: true,
            child: AppIcon(Icons.attach_file, faded: true),
          ),
          //
          spw(),
          MoreInputActions(),
          //
        ],
      );
    });
  }
}
