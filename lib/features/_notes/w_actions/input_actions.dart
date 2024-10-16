import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_providers/input.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/color.dart';
import '../../../_widgets/others/color_menu.dart';
import '../../../_widgets/others/icons.dart';
import '../types/finance/graphs_sheet.dart';
import '../w/emoji_menu.dart';
import 'input_actions_more.dart';

class CommonInputActions extends StatelessWidget {
  const CommonInputActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      bool isPinned = input.item.isPinned();

      return Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: smallWidth(),
        runSpacing: smallWidth(),
        children: [
          //
          AppButton(
            tooltip: 'Emoji',
            menuItems: emojiMenu(input.item),
            noStyling: true,
            isSquare: true,
            child: AppIcon(Icons.emoji_emotions_outlined, tiny: true, faded: true),
          ),
          //
          ColorButton(
            menuItems: colorMenu(
              selectedColor: input.item.color(),
              onSelect: (newColor) => input.update('c', newColor),
            ),
            color: input.item.color(),
          ),

          //
          AppButton(
            onPressed: () => input.update('p', isPinned ? '0' : '1'),
            tooltip: isPinned ? 'UnPin' : 'Unpin',
            noStyling: true,
            isSquare: true,
            child: AppIcon(isPinned ? pinIcon : unpinIcon, tiny: true, faded: true),
          ),
          //
          MoreInputActions(),
          //
          if (input.item.isFinance())
            AppButton(
              onPressed: () => showFinanceGraphsBottomSheet(),
              tooltip: 'View Graphs',
              noStyling: true,
              isSquare: true,
              child: AppIcon(Icons.insert_chart_outlined_rounded, tiny: true, faded: true),
            ),
          //
        ],
      );
    });
  }
}
