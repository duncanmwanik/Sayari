import 'package:flutter/material.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/text.dart';

class Tile extends StatelessWidget {
  const Tile({
    super.key,
    required this.title,
    required this.count,
    this.trailing,
    required this.child,
    this.iconData = Icons.folder_rounded,
    this.initiallyExpanded = false,
    this.onExpansionChanged,
  });

  final String title;
  final int count;
  final Widget? trailing;
  final Widget child;
  final IconData iconData;
  final bool initiallyExpanded;
  final Function(bool)? onExpansionChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusSmall + 5),
        side: styler.lightTableBorder(),
      ),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(bottom: 5),
      child: ExpansionTile(
        dense: true,
        initiallyExpanded: initiallyExpanded,
        tilePadding: EdgeInsets.only(left: 10, right: 5),
        childrenPadding: itemPaddingMedium(),
        shape: Border(),
        iconColor: styler.textColor(faded: true),
        trailing: trailing,
        title: Row(
          children: [
            AppIcon(iconData, faded: true, size: 18),
            tpw(),
            AppText(size: small, text: '$count', faded: true),
            mpw(),
            Flexible(child: AppText(text: title)),
          ],
        ),
        children: [child],
      ),
    );
  }
}
