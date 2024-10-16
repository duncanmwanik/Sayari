import 'package:flutter/material.dart';

import '../../_helpers/navigation.dart';
import '../../_theme/helpers.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../menu/menu.dart';
import '../others/blur.dart';
import '../others/icons.dart';
import '../others/others/dry_intrinsic_size.dart';
import '../others/text.dart';
import '../others/tooltip.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.enabled = true,
    this.onPressed,
    this.onLongPress,
    this.onHover,
    this.showMenuOnLongPress = false,
    this.leading,
    this.label,
    this.trailing,
    this.child,
    this.iconSize = 18,
    this.textSize = medium,
    this.borderRadius,
    this.customBorder,
    this.color,
    this.hoverColor,
    this.bgColor,
    this.textColor,
    this.borderColor,
    this.showBorder = false,
    this.isRound = false,
    this.isSquare = false,
    this.iconFaded = false,
    this.margin,
    this.padding,
    this.slp = false,
    this.srp = false,
    this.svp = false,
    this.isDropDown = false,
    this.dryWidth = false,
    this.noStyling = false,
    this.blur = false,
    this.borderWidth,
    this.maxWidth,
    this.maxHeight,
    this.width,
    this.height,
    this.tooltip,
    this.tooltipDirection,
    this.menuItems = const [],
    this.menuWidth,
    this.keepMenuPosition = false,
    this.popMenu = false,
    this.mouseCursor,
  });

  final bool enabled;
  final Function()? onPressed;
  final Function()? onLongPress;
  final Function(bool)? onHover;
  final bool showMenuOnLongPress;
  final IconData? leading;
  final String? label;
  final IconData? trailing;
  final Widget? child;
  final double iconSize;
  final double textSize;
  final Color? color;
  final Color? hoverColor;
  final Color? textColor;
  final String? bgColor;
  final Color? borderColor;
  final double? borderRadius;
  final ShapeBorder? customBorder;
  final bool showBorder;
  final bool isRound;
  final bool isSquare;
  final bool iconFaded;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final bool slp;
  final bool srp;
  final bool svp;
  final bool isDropDown;
  final bool dryWidth;
  final bool noStyling;
  final bool blur;
  final double? borderWidth;
  final double? maxWidth;
  final double? maxHeight;
  final double? width;
  final double? height;
  final String? tooltip;
  final AxisDirection? tooltipDirection;
  final List<Widget>? menuItems;
  final double? menuWidth;
  final bool popMenu;
  final bool keepMenuPosition;
  final MouseCursor? mouseCursor;

  @override
  Widget build(BuildContext context) {
    bool isMenu = menuItems != null && menuItems!.isNotEmpty;

    Widget button = IgnorePointer(
      ignoring: !enabled,
      child: Blur(
        enabled: blur,
        radius: isRound ? borderRadiusCrazy : borderRadiusTiny,
        child: Material(
          color: noStyling ? transparent : color ?? (hasColour(bgColor) ? Colors.white24 : styler.appColor(styler.isDark ? 1.3 : 1.5)),
          shape: customBorder != null
              ? CircleBorder()
              : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? (isRound ? borderRadiusCrazy : borderRadiusTiny)),
                  side: showBorder
                      ? BorderSide(color: borderColor ?? Colors.grey.withOpacity(0.3), width: borderWidth ?? (isDark() ? 0.4 : 0.8))
                      : BorderSide.none,
                ),
          child: InkWell(
            onTap: isMenu ? () {} : onPressed,
            onLongPress: showMenuOnLongPress
                ? () {
                    if (popMenu) popWhatsOnTop(); //pops popupmenu
                    showAppMenu(Offset(0, 0), menuItems!, width: menuWidth, keepMenuPosition: keepMenuPosition);
                  }
                : onLongPress,
            onHover: onHover,
            onTapDown: isMenu
                ? (details) {
                    if (popMenu) popWhatsOnTop(); //pops popupmenu
                    showAppMenu(details.globalPosition, menuItems!, width: menuWidth, keepMenuPosition: keepMenuPosition);
                  }
                : null,
            customBorder: customBorder,
            borderRadius:
                customBorder != null ? null : BorderRadius.circular(borderRadius ?? (isRound ? borderRadiusCrazy : borderRadiusTiny)),
            hoverColor: hoverColor,
            highlightColor: hoverColor,
            splashColor: hoverColor,
            mouseCursor: mouseCursor,
            child: Container(
              constraints: BoxConstraints(
                minHeight: height ?? 0,
                minWidth: width ?? 0,
                maxWidth: maxWidth ?? double.infinity,
                maxHeight: maxHeight ?? double.infinity,
              ),
              padding: padding ??
                  (isRound
                      ? const EdgeInsets.all(6)
                      : EdgeInsets.only(
                          left: slp || isSquare ? 8 : 12,
                          right: srp || isSquare ? 8 : (isDropDown ? 9 : 12),
                          top: svp ? 3 : 6,
                          bottom: svp ? 3 : 6,
                        )),
              child: child ??
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (leading != null) AppIcon(leading, size: iconSize, faded: iconFaded, color: textColor, bgColor: bgColor),
                      if (leading != null && label != null) spw(),
                      if (label != null) AppText(text: label ?? '', size: textSize, color: textColor, bgColor: bgColor),
                      if (trailing != null && label != null) spw(),
                      if (trailing != null) AppIcon(trailing, size: iconSize, faded: iconFaded, color: textColor, bgColor: bgColor),
                    ],
                  ),
            ),
          ),
        ),
      ),
    );

    return Padding(
      padding: margin ?? noPadding,
      child: AppTooltip(
        message: tooltip,
        axisDirection: tooltipDirection,
        child: dryWidth ? DryIntrinsicWidth(child: button) : button,
      ),
    );
  }
}
