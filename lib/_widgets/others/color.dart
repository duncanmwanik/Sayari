import 'package:flutter/material.dart';

import '../../_theme/helpers.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../buttons/button.dart';
import 'icons.dart';
import 'svg.dart';

class ColorButton extends StatelessWidget {
  const ColorButton({super.key, this.color, required this.menuItems, this.isSmall = false});

  final String? color;
  final List<Widget> menuItems;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    bool hasColor = hasColour(color);

    return AppButton(
      tooltip: 'Color',
      menuItems: menuItems,
      isSquare: true,
      noStyling: true,
      isDropDown: true,
      height: isSmall ? null : 23,
      child: isSmall
          ? const AppIcon(Icons.color_lens_rounded, size: 16, faded: true)
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppIcon(
                  Icons.lens,
                  size: 20,
                  color: hasColor ? styler.getItemColor(color, false) : (styler.isDark ? Colors.white24 : Colors.black54),
                ),
                pw(3),
                const AppSvg(dropDownSvg, size: 14),
              ],
            ),
    );
  }
}
