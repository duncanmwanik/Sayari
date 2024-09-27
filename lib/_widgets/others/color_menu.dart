import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/navigation.dart';
import '../../_variables/colors.dart';
import '../buttons/button.dart';
import '../menu/menu_item.dart';
import 'color_item.dart';
import 'icons.dart';

List<Widget> colorMenu({String? selectedColor, String title = '', Function(String newColor)? onSelect}) {
  return [
    //
    if (title.isNotEmpty) MenuItem(label: title, smallHeight: true, popTrailing: true),
    if (title.isNotEmpty) menuDivider(),
    //
    Wrap(
      spacing: tinyWidth(),
      runSpacing: tinyWidth(),
      children: [
        //
        AppButton(
          onPressed: () => popWhatsOnTop(todo: () => onSelect!('')),
          isSquare: true,
          width: 30,
          height: 30,
          dryWidth: true,
          padding: noPadding,
          color: styler.appColor(1),
          child: Center(
            child: AppIcon(Icons.close, size: 15, faded: true),
          ),
        ),
        //
        for (String color in backgroundColors.keys) ColorItem(color: color, selectedColor: selectedColor, onSelect: onSelect),
        //
      ],
    ),
  ];
}
