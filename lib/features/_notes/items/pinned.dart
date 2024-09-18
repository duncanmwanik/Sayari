import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_models/item.dart';
import '../../../_providers/common/misc.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';

class PinnedIcon extends StatelessWidget {
  const PinnedIcon({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Consumer<HoverProvider>(builder: (context, hover, child) {
      bool isHovered = hover.id == item.id;

      return Visibility(
        visible: item.isPinned(),
        child: AppButton(
          noStyling: true,
          isSquare: true,
          padding: padding(p: 3),
          child: AppIcon(
            item.isPinned() ? pinIcon : unpinIcon,
            color: item.isPinned() || isHovered ? null : transparent,
            bgColor: item.color(),
            size: medium,
            faded: true,
          ),
        ),
      );
    });
  }
}
