import 'package:flutter/material.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_helpers/_common/global.dart';
import '../../../../../_providers/providers.dart';
import '../../../../../_variables/colors.dart';
import '../../../../../_widgets/buttons/buttons.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/text.dart';
import '../../../../_spaces/_helpers/checks_space.dart';
import '../../../../flags/_helpers/manage_flag.dart';
import '../../../../flags/flags_menu.dart';

class ItemFlag extends StatelessWidget {
  const ItemFlag({super.key, required this.flag, this.isTinyFlag = false, this.onPressedDelete});

  final String flag;
  final bool isTinyFlag;
  final Function()? onPressedDelete;

  @override
  Widget build(BuildContext context) {
    if (isTinyFlag) {
      return Container(
        width: 30,
        height: 8,
        decoration: BoxDecoration(
          color: backgroundColors[getFlagColor(flag)]!.color,
          borderRadius: BorderRadius.circular(borderRadiusSmall),
        ),
      );
    } else {
      return AppButton(
        menuWidth: 300,
        menuItems: flagsMenu(
          alreadySelected: getSplitList(state.input.data['g']),
          onDone: (newFlags) => state.input.update('g', getJoinedList(newFlags)),
        ),
        color: backgroundColors[getFlagColor(flag)]!.color,
        padding: padding(l: 8, t: 2, b: 2, r: 0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // flag text
            Flexible(child: AppText(text: flag, color: backgroundColors[getFlagColor(flag)]!.textColor)),
            //
            spw(),
            // remove flag
            if (isAdmin())
              AppButton(
                onPressed: onPressedDelete ?? () {},
                noStyling: true,
                isSquare: true,
                child: AppIcon(Icons.close, color: backgroundColors[getFlagColor(flag)]!.textColor, size: normal),
              ),
            //
          ],
        ),
      );
    }
  }
}
