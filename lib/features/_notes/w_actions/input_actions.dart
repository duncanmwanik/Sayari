import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../_helpers/global.dart';
import '../../../_providers/input.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/color.dart';
import '../../../_widgets/others/color_menu.dart';
import '../../../_widgets/others/icons.dart';
import '../../files/_helpers/upload.dart';
import '../../reminders/reminder_menu.dart';
import '../../tags/menu.dart';
import '../finance/graphs_sheet.dart';
import '../habits/header.dart';
import 'input_actions_more.dart';

class CommonInputActions extends StatelessWidget {
  const CommonInputActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      String? reminder = input.item.data['r'];
      String? bgColor = input.item.data['c'];
      bool isPinned = input.item.data['p'] == '1';

      return Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          //
          if (input.item.isHabit()) spw(),
          if (input.item.isHabit()) HabitHeader(),
          //
          if (input.item.isFinance()) spw(),
          if (input.item.isFinance())
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
            menuItems: tagsMenu(
              isSelection: true,
              alreadySelected: splitList(input.item.data['l']),
              onDone: (newTags) => input.update('l', newTags.join('|')),
            ),
            tooltip: 'Tag',
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
            color: bgColor,
          ),
          //
          spw(),
          AppButton(
            onPressed: () async => await getFilesToUpload(),
            tooltip: 'Attach File',
            noStyling: true,
            isSquare: true,
            child: AppIcon(Icons.attach_file, tiny: true, faded: true),
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
