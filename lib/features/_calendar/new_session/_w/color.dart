import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_providers/common/input.dart';
import '../../../../_widgets/abcs/buttons/color_button.dart';
import '../../../../_widgets/others/color_menu.dart';

class SessionColor extends StatelessWidget {
  const SessionColor({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      return ColorButton(
        menuItems: colorMenu(
          selectedColor: input.data['c'],
          onSelect: (newColor) => input.update(action: 'add', key: 'c', value: newColor),
        ),
        bgColor: input.data['c'],
      );
    });
  }
}
