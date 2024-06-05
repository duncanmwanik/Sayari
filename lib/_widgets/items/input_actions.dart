import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/global.dart';
import '../../../_providers/common/input.dart';
import '../../features/labels/labels_menu.dart';
import '../../features/notes/feat/finance/_w/toggler.dart';
import '../../features/notes/feat/finance/graphs_sheet.dart';
import '../../features/notes/feat/habits/header.dart';
import '../../features/reminders/reminder_menu.dart';
import '../abcs/buttons/buttons.dart';
import '../abcs/buttons/color_button.dart';
import '../others/color_menu.dart';
import '../others/icons.dart';
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
          if (input.isFinance()) FinanceToggler(),
          if (input.isHabit()) HabitHeader(),
          //
          spw(),
          //
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
          //
          AppButton(
            onPressed: () => input.update(action: 'add', key: 'p', value: isPinned ? '0' : '1'),
            tooltip: isPinned ? 'UnPin' : 'Unpin',
            noStyling: true,
            isSquare: true,
            child: AppIcon(isPinned ? pinIcon : unpinIcon, faded: true),
          ),
          //
          spw(),
          //
          AppButton(
            tooltip: 'Reminder',
            menuWidth: 200,
            menuItems: reminderMenu(
              reminder: reminder,
              onSet: (newReminder) => input.update(action: 'add', key: 'r', value: newReminder),
              onRemove: () => input.update(action: 'remove', key: 'r'),
            ),
            noStyling: true,
            isSquare: true,
            child: AppIcon(Icons.notifications_none, faded: true),
          ),
          //
          spw(),
          //
          AppButton(
            menuItems: labelsMenu(
              isSelection: true,
              alreadySelected: getSplitList(input.data['l']),
              onDone: (newLabels) => input.update(action: 'add', key: 'l', value: newLabels.join('|')),
            ),
            tooltip: 'Label',
            noStyling: true,
            isSquare: true,
            child: AppIcon(labelIcon, faded: true),
          ),
          //
          spw(),
          //
          ColorButton(
            menuItems: colorMenu(
              selectedColor: bgColor,
              onSelect: (newColor) => input.update(action: 'add', key: 'c', value: newColor),
            ),
            bgColor: bgColor,
          ),
          //
          spw(),
          //
          MoreInputActions(),
          //
        ],
      );
    });
  }
}
