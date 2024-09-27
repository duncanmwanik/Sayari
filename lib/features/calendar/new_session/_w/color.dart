import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_providers/input.dart';
import '../../../../_widgets/others/color.dart';
import '../../../../_widgets/others/color_menu.dart';

class SessionColor extends StatelessWidget {
  const SessionColor({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      return ColorButton(
        menuItems: colorMenu(
          selectedColor: input.item.data['c'],
          onSelect: (newColor) => input.update('c', newColor),
        ),
        color: input.item.data['c'],
      );
    });
  }
}
