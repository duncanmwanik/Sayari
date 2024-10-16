import 'package:flutter/material.dart';

import '../../../../../_helpers/global.dart';
import '../../../../../_providers/_providers.dart';
import '../../../../../_services/hive/store.dart';
import '../../../../../_theme/spacing.dart';
import '../../../../../_theme/variables.dart';
import '../../../../../_variables/colors.dart';
import '../../../../../_variables/features.dart';
import '../../../../../_widgets/buttons/button.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/text.dart';
import '../../../../_spaces/_helpers/common.dart';
import '../../../../flags/flags_menu.dart';

class ItemFlag extends StatelessWidget {
  const ItemFlag({super.key, required this.flagId, this.isTinyFlag = false, this.onPressedDelete});

  final String flagId;
  final bool isTinyFlag;
  final Function()? onPressedDelete;

  @override
  Widget build(BuildContext context) {
    String flagData = storage(feature.flags).get(flagId, defaultValue: '0,Flag');
    String color = flagData.substring(0, flagData.indexOf(','));
    String flag = flagData.substring(flagData.indexOf(',') + 1);

    return AppButton(
      menuWidth: 300,
      menuItems: isTinyFlag
          ? null
          : flagsMenu(
              alreadySelected: state.input.item.flags(),
              onDone: (newFlags) => newFlags.isNotEmpty ? state.input.update('g', joinList(newFlags)) : state.input.remove('g'),
            ),
      color: backgroundColors[color]!.color,
      padding: isTinyFlag ? noPadding : pad(c: 'l8,r4,t2,b2'),
      width: isTinyFlag ? 30 : null,
      height: isTinyFlag ? 8 : null,
      svp: true,
      child: isTinyFlag
          ? null
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // flag text
                Flexible(child: AppText(text: flag, color: backgroundColors[color]!.textColor)),
                spw(),
                // remove flag
                if (isAdmin())
                  AppButton(
                    onPressed: onPressedDelete ?? () {},
                    noStyling: true,
                    padding: noPadding,
                    child: AppIcon(Icons.close, color: backgroundColors[color]!.textColor, size: normal),
                  ),
                //
              ],
            ),
    );
  }
}
