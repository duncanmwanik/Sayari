import 'package:flutter/material.dart';

import '../_widgets/buttons/button.dart';
import 'spacing.dart';
import 'theme_menu.dart';
import 'variables.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({super.key, this.showText = false, this.rightPadding = true});
  final bool showText;
  final bool rightPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: rightPadding ? paddingM('r') : noPadding,
      child: AppButton(
        menuWidth: 300,
        menuItems: themeMenu(),
        tooltip: 'Theme',
        isSquare: true,
        noStyling: true,
        iconSize: showText ? normal : 18,
        textSize: small,
        iconFaded: !showText,
        leading: Icons.dark_mode,
        label: showText ? 'Change Theme' : null,
      ),
    );
  }
}
