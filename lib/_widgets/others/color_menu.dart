import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../_variables/colors.dart';
import '../menu/menu_item.dart';
import 'color_item.dart';

List<Widget> colorMenu({String? selectedColor, String title = '', Function(String newColor)? onSelect}) {
  return [
    //
    if (title.isNotEmpty) MenuItem(label: title),
    if (title.isNotEmpty) menuDivider(),
    //
    Wrap(
      spacing: tinyWidth(),
      runSpacing: tinyWidth(),
      children: List.generate(backgroundColors.length, (index) {
        String colorKey = backgroundColors.keys.toList()[index];

        return ColorItem(colorKey: colorKey, selectedColor: selectedColor, onSelect: onSelect);
      }),
    ),
  ];
}
