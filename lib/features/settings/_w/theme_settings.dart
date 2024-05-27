import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/providers.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/others/list_tile.dart';
import '../../../_widgets/others/text.dart';
import '../../../_widgets/others/theme.dart';
import 'title.dart';

class ThemeSettings extends StatelessWidget {
  const ThemeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //
        SettingTitle('THEME'),
        //
        sph(),
        //
        AppButton(
          menuWidth: 300,
          menuItems: themeMenu(),
          noStyling: true,
          padding: EdgeInsets.zero,
          borderRadius: borderRadiusSmall,
          child: AbsorbPointer(
            child: AppListTile(
              leading: AppText(text: '${state.theme.themeImage.substring(0, 1).toUpperCase()}${state.theme.themeImage.substring(1)}'),
              trailing: AppIcon(Icons.keyboard_arrow_right_rounded, size: normal),
            ),
          ),
        ),
        //
      ],
    );
  }
}
