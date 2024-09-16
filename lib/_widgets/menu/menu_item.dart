import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/_common/navigation.dart';
import '../buttons/buttons.dart';
import '../others/icons.dart';
import '../others/text.dart';

class MenuItem extends StatefulWidget {
  const MenuItem({
    super.key,
    required this.label,
    this.onTap,
    this.menuItems,
    this.leading,
    this.trailing,
    this.trailingColor,
    this.hoverColor,
    this.leadingSize,
    this.trailingSize,
    this.smallHeight = false,
    this.faded = false,
    this.isSelected = false,
    this.center = false,
    this.pop = true,
  });

  final String label;
  final IconData? leading;
  final Function()? onTap;
  final List<Widget>? menuItems;
  final IconData? trailing;
  final Color? trailingColor;
  final Color? hoverColor;
  final double? leadingSize;
  final double? trailingSize;
  final bool smallHeight;
  final bool faded;
  final bool isSelected;
  final bool center;
  final bool pop;

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
        onPressed: widget.onTap != null
            ? () {
                if (widget.pop) popWhatsOnTop(); //pops popupmenu
                Future.delayed(const Duration(seconds: 0), widget.onTap); // Future.delayed prevents onTap not working
              }
            : null,
        menuItems: widget.menuItems,
        popMenu: widget.menuItems != null,
        padding: padding(
          l: 8,
          t: widget.smallHeight ? 1 : 6,
          b: widget.smallHeight ? 1 : 6,
          r: widget.trailing != null ? 8 : 12,
        ),
        borderRadius: borderRadiusTinySmall,
        hoverColor: widget.hoverColor,
        noStyling: true,
        child: Row(
          children: [
            if (widget.leading != null)
              AppIcon(
                widget.leading,
                size: widget.leadingSize ?? normal,
                faded: !isHovered,
                color: widget.isSelected ? styler.accentColor() : null,
              ),
            if (widget.leading != null) spw(),
            Expanded(
              child: AppText(
                text: widget.label,
                // faded: !isHovered,
                fontWeight: widget.isSelected ? FontWeight.w800 : FontWeight.w700,
                color: widget.isSelected ? styler.accentColor() : null,
                extraFaded: widget.faded,
                textAlign: widget.center ? TextAlign.center : null,
              ),
            ),
            if (widget.trailing != null) spw(),
            if (widget.trailing != null)
              AppIcon(
                widget.trailing,
                size: widget.trailingSize ?? 16,
                faded: !isHovered,
                color: widget.isSelected ? styler.accentColor() : widget.trailingColor,
              ),
          ],
        ),
      ),
    );
  }
}
