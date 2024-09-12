import 'package:flutter/material.dart';

import '../../../__styling/variables.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/abcs/menu/menu_item.dart';
import '../../../_widgets/others/icons.dart';
import '../_helpers/quick_edit.dart';

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
          leading: deleteIcon,
          onTap: () async => await editItemExtras(type: type, itemId: itemId, key: 'x', value: '1'),
        ),
      ],
      noStyling: true,
      isSquare: true,
      child: AppIcon(moreIcon, bgColor: bgColor, faded: true, size: 18),
    );
  }
}
