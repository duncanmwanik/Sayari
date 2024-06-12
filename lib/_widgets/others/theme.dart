import 'package:flutter/material.dart';

import '../../__styling/helpers.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/_common/navigation.dart';
import '../../_providers/providers.dart';
import '../../_variables/colors.dart';
import '../abcs/buttons/buttons.dart';
import 'color_menu.dart';
import 'others/divider.dart';
import 'text.dart';

class QuickThemeChanger extends StatelessWidget {
  const QuickThemeChanger({super.key, this.showText = false, this.rightPadding = true});
  final bool showText;
  final bool rightPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: itemPadding(right: rightPadding),
      child: AppButton(
        menuWidth: 300,
        menuItems: themeMenu(),
        tooltip: 'Theme',
        isRound: true,
        noStyling: true,
        iconSize: showText ? normal : 18,
        textSize: small,
        iconFaded: !showText,
        leading: Icons.wb_sunny_rounded,
        label: showText ? 'Change Theme' : null,
      ),
    );
  }
}

List<Widget> themeMenu() {
  Map<String, ColorObject> accentColors = {...backgroundColors};
  accentColors.removeWhere((key, value) => !value.isThemeAccent);

  return [
    GridView.count(
      shrinkWrap: true,
      mainAxisSpacing: tinyWidth(),
      crossAxisSpacing: tinyWidth(),
      crossAxisCount: 2,
      childAspectRatio: 2.8,
      children: List.generate(themeImages.length, (index) {
        String themeImage = themeImages.keys.toList()[index];
        String themeType = themeImages[themeImage] ?? 'light';
        Color color = themeType == 'light' ? black : white;

        return AppButton(
          onPressed: () {
            popWhatsOnTop(); // close theme menu
            state.theme.setThemeImage(themeImage, themeType, state.theme.themeAccent);
          },
          noStyling: true,
          padding: EdgeInsets.zero,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadiusSmall - 2),
              image: DecorationImage(image: AssetImage(getThemeImage(themeImage)), fit: BoxFit.cover),
              border: Border.all(color: themeImage == state.theme.themeImage ? styler.borderColor() : transparent),
            ),
            child: Center(
              child: AppText(
                size: small,
                text: '${themeImage.substring(0, 1).toUpperCase()}${themeImage.substring(1)}',
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
      }),
    ),
    //
    AppDivider(height: mediumHeight()),
    //
    GridView.count(
      shrinkWrap: true,
      mainAxisSpacing: tinyWidth(),
      crossAxisSpacing: tinyWidth(),
      crossAxisCount: 8,
      children: List.generate(accentColors.length, (index) {
        String colorKey = accentColors.keys.toList()[index];

        return ColorItem(
          colorKey: colorKey,
          selectedColor: state.theme.themeAccent,
          onSelect: (newColor) {
            state.theme.setThemeImage(state.theme.themeImage, state.theme.themeType, newColor);
          },
        );
      }),
    ),
    //
  ];
}
