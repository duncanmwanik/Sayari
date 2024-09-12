import 'package:flutter/material.dart';

import '../../../__styling/helpers.dart';
import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../others/icons.dart';
import '../../others/others/dry_intrinsic_size.dart';
import '../../others/text.dart';
import '../../others/tooltip.dart';
import '../menu/menu.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.onPressed,
    this.onLongPress,
    this.onHover,
    this.leading,
    this.label,
    this.trailing,
    this.child,
    this.iconSize = 18,
    this.textSize = medium,
    this.borderRadius,
    this.color,
    this.hoverColor,
    this.textColor,
    this.borderColor,
    this.showBorder = false,
    this.isRound = false,
    this.isSquare = false,
    this.iconFaded = false,
    this.padding,
    this.smallLeftPadding = false,
    this.smallRightPadding = false,
    this.smallVerticalPadding = false,
    this.isDropDown = false,
    this.dryWidth = false,
    this.noStyling = false,
    this.borderWidth,
    this.width,
    this.height,
    this.tooltip,
    this.tooltipDirection,
    this.menuItems = const [],
    this.menuWidth,
    this.popMenu = false,
  });

  final Function()? onPressed;
  final Function()? onLongPress;
  final Function(bool)? onHover;
  final IconData? leading;
  final String? label;
  final IconData? trailing;
  final Widget? child;
  final double iconSize;
  final double textSize;
  final Color? color;
  final Color? hoverColor;
  final Color? textColor;
  final Color? borderColor;
  final double? borderRadius;
  final bool showBorder;
  final bool isRound;
  final bool isSquare;
  final bool iconFaded;
  final EdgeInsets? padding;
  final bool smallLeftPadding;
  final bool smallRightPadding;
  final bool smallVerticalPadding;
  final bool isDropDown;
  final bool dryWidth;
  final bool noStyling;
  final double? borderWidth;
  final double? width;
  final double? height;
  final String? tooltip;
  final AxisDirection? tooltipDirection;
  final List<Widget>? menuItems;
  final double? menuWidth;
  final bool popMenu;

  @override
  Widget build(BuildContext context) {
    bool isMenu = menuItems != null && menuItems!.isNotEmpty;

    Widget button = Material(
      color: noStyling ? transparent : color ?? styler.appColor(styler.isDark ? 1.3 : 1.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? (isRound ? borderRadiusCrazy : borderRadiusSmall)),
        side: showBorder
            ? BorderSide(color: borderColor ?? Colors.grey.withOpacity(0.3), width: borderWidth ?? (isDark() ? 0.4 : 0.8))
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: isMenu ? () {} : onPressed,
        onLongPress: isMenu ? () {} : onLongPress,
        onHover: onHover,
        onTapDown: isMenu
            ? (details) {
                if (popMenu) popWhatsOnTop(); //pops popupmenu
                showAppMenu(details.globalPosition, menuItems!, width: menuWidth);
              }
            : null,
        borderRadius: BorderRadius.circular(borderRadius ?? (isRound ? borderRadiusCrazy : borderRadiusSmall)),
        hoverColor: hoverColor,
        highlightColor: hoverColor,
        splashColor: hoverColor,
        child: Container(
          constraints: BoxConstraints(minHeight: height ?? 0, minWidth: width ?? 0),
          padding: padding ??
              (isRound
                  ? const EdgeInsets.all(6)
                  : EdgeInsets.only(
                      left: smallLeftPadding || isSquare ? 6 : 12,
                      right: smallRightPadding || isSquare ? 6 : (isDropDown ? 9 : 12),
                      top: smallVerticalPadding ? 3 : 6,
                      bottom: smallVerticalPadding ? 3 : 6,
                    )),
          child: child ??
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (leading != null) AppIcon(leading, size: iconSize, faded: iconFaded, color: textColor),
                  if (leading != null && label != null) spw(),
                  if (label != null) AppText(text: label ?? '', size: textSize, color: textColor),
                  if (trailing != null && label != null) spw(),
                  if (trailing != null) AppIcon(trailing, size: iconSize, faded: iconFaded, color: textColor),
                ],
              ),
        ),
      ),
    );

    return AppTooltip(
      message: tooltip,
      axisDirection: tooltipDirection,
      child: dryWidth ? DryIntrinsicWidth(child: button) : button,
    );
  }
}
