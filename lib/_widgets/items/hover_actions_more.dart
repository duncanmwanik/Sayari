import 'package:flutter/material.dart';

import '../../__styling/variables.dart';
import '../../features/_notes/_helpers/quick_edit.dart';
import '../abcs/buttons/buttons.dart';
import '../abcs/menu/menu_item.dart';
import '../others/icons.dart';

class HoverActionsMore extends StatelessWidget {
  const HoverActionsMore({super.key, required this.itemId, required this.type, this.bgColor});

  final String itemId;
  final String type;
  final String? bgColor;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      tooltip: 'More',
      menuItems: [
        MenuItem(
          label: 'Move To Trash',
          iconData: deleteIcon,
          onTap: () async => await editItemExtras(type: type, itemId: itemId, key: 'x', value: '1'),
        ),
      ],
      noStyling: true,
      isSquare: true,
      child: AppIcon(moreIcon, bgColor: bgColor, faded: true, size: 18),
    );
  }
}
