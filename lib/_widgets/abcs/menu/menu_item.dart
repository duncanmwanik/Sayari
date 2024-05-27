import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../others/icons.dart';
import '../../others/text.dart';
import '../buttons/buttons.dart';

class MenuItem extends StatefulWidget {
  const MenuItem({
    super.key,
    required this.label,
    required this.onTap,
    this.iconData,
    this.trailing,
    this.trailingColor,
    this.leadingSize,
  });

  final String label;
  final IconData? iconData;
  final Function() onTap;
  final IconData? trailing;
  final Color? trailingColor;
  final double? leadingSize;

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => isHovered = true),
      onExit: (event) => setState(() => isHovered = false),
      child: AppButton(
        onPressed: () {
          popWhatsOnTop(); //pops popupmenu
          Future.delayed(Duration(seconds: 0), widget.onTap); // Future.delayed prevents onTap not working
        },
        padding: EdgeInsets.only(left: 8, top: kIsWeb ? 5 : 7, bottom: kIsWeb ? 5 : 7, right: widget.trailing != null ? 8 : 12),
        borderRadius: borderRadiusTinySmall,
        noStyling: true,
        child: Row(
          children: [
            if (widget.iconData != null) AppIcon(widget.iconData, size: widget.leadingSize ?? 16, faded: !isHovered),
            if (widget.iconData != null) spw(),
            Expanded(
              child: AppText(
                text: widget.label,
                faded: !isHovered,
                fontWeight: FontWeight.w600,
                // fontWeight: isHovered ? FontWeight.lerp(FontWeight.w600, FontWeight.w700, 0.5) : null,
              ),
            ),
            if (widget.trailing != null) spw(),
            if (widget.trailing != null) AppIcon(widget.trailing, size: 16, color: widget.trailingColor, faded: !isHovered),
          ],
        ),
      ),
    );
  }
}
