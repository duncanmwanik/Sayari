import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/variables.dart';
import '../../_helpers/items/quick_edit.dart';
import '../../_models/item.dart';
import '../../_providers/common/misc.dart';
import '../abcs/buttons/buttons.dart';
import '../others/icons.dart';

class PinnedIcon extends StatelessWidget {
  const PinnedIcon({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Consumer<HoverProvider>(builder: (context, hover, child) {
      bool isHovered = hover.id == item.id;

      return AppButton(
        onPressed: () async {
          await editItemExtras(type: item.type, itemId: item.id, key: 'p', value: item.isPinned() ? '0' : '1');
        },
        tooltip: item.isPinned() ? 'Unpin' : 'Pin',
        noStyling: true,
        isSquare: true,
        child: AppIcon(
          item.isPinned() ? pinIcon : unpinIcon,
          color: item.isPinned() || isHovered ? null : transparent,
          bgColor: item.color(),
          size: 16,
        ),
      );
    });
  }
}
