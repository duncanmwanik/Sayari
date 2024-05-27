import 'package:flutter/material.dart';

import '../../../__styling/helpers.dart';
import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../others/icons.dart';
import '../../others/svg.dart';
import 'buttons.dart';

class ColorButton extends StatelessWidget {
  const ColorButton({super.key, this.bgColor, required this.menuItems, this.isSmall = false});

  final String? bgColor;
  final List<Widget> menuItems;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    bool hasColor = hasBgColor(bgColor);

    return AppButton(
      tooltip: 'Color',
      menuItems: menuItems,
      isSquare: true,
      noStyling: true,
      height: isSmall ? null : 23,
      child: isSmall
          ? AppIcon(Icons.edit_rounded, size: 12, color: Colors.black)
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppIcon(
                  Icons.lens,
                  size: 20,
                  color: hasColor ? styler.getItemColor(bgColor, false) : (styler.isDark ? Colors.white24 : Colors.black54),
                ),
                pw(3),
                AppSvg(svgPath: 'assets/icons/dropdown.svg', size: 14),
              ],
            ),
    );
  }
}
