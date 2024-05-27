import 'package:flutter/material.dart';

import '../_providers/providers.dart';
import '../_variables/colors.dart';
import 'helpers.dart';
import 'variables.dart';

class AppColors {
  static const Color accent = Colors.red;

  static Color accentHoverButton = Colors.grey;

  static const Color cursorColor = Colors.redAccent;

  static const Color transparent = Colors.transparent;

  static Color fabColor = accent;

  static const Color darkPrimary = Color(0xff1b1d1c);
  static const Color lightPrimary = Color(0xffffffff);

  static const Color darkSecondary = Color(0xff272829);
  static const Color lightSecondary = Color(0xfffcfcfd);

  static const Color darkTertiary = Color(0xff282a29);
  static const Color lightTertiary = Color(0xffefefef);

  static Color lightHover = Colors.grey.withOpacity(0.2);
  static Color darkHover = Colors.grey.withOpacity(0.1);

  static const Color darkBar = Color(0xff222222);
  static const Color lightBar = Color(0xffefefef);

  static const Color darkText = Colors.white;
  static const Color lightText = Color(0xff333333);

  static Color darkTextFaded = Colors.white.withOpacity(0.7);
  static Color lightTextFaded = Color(0xff333333).withOpacity(0.8);

  static Color darkTextExtraFaded = Colors.white.withOpacity(0.3);
  static Color lightTextExtraFaded = Color(0xff333333).withOpacity(0.4);

  static const Color darkDividerColor = Colors.white12;
  static const Color lightDividerColor = Colors.black12;

  static const Color darkBottomNavBarColor = Color(0xff2f2f2f);
  static const Color lightBottomNavBarColor = Color(0xfff7f7f7);

  static Color textSelectionColor = accent.withOpacity(0.3);
}

class AppStyles {
  bool isDark = false;
  Color accent = backgroundColors[state.theme.themeAccent]!.color;

  void initialize(bool value) {
    isDark = value;
    accent = backgroundColors[state.theme.themeAccent]!.color;
  }

  // -------------------------- Primary Colors
  Color accentColor([double? opacity]) {
    return accent.withOpacity((opacity ?? 10) / 10);
  }

  Color primaryColor() {
    return isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
  }

  Color secondaryColor() {
    return isDark ? AppColors.darkSecondary : AppColors.lightSecondary;
  }

  Color tertiaryColor() {
    return isDark ? AppColors.darkTertiary : AppColors.lightTertiary;
  }

  Color navColor() {
    return isImageTheme()
        ? transparent
        : isBlackTheme()
            ? black
            : isDark
                ? AppColors.darkPrimary
                : AppColors.lightPrimary;
  }

  Color appColor(double weight) {
    return Colors.grey.withOpacity(weight / 10);
  }

  Color hoverColor() {
    return isDark ? Color(0xff1e1f1e) : Color(0xfff7f7f7);
  }

  // -------------------------- Text Colors

  Color textColor({bool faded = false, bool extraFaded = false, String? bgColor}) {
    if (hasBgColor(bgColor)) {
      return AppColors.lightText;
    } else {
      if (extraFaded) return isDark ? AppColors.darkTextExtraFaded : AppColors.lightTextExtraFaded;
      if (faded) return isDark ? AppColors.darkTextFaded : AppColors.lightTextFaded;
      return isDark ? AppColors.darkText : AppColors.lightText;
    }
  }

  Color invertedTextColor() => isDark ? AppColors.lightText : AppColors.darkText;

  // -------------------------- Other Colors

  Color borderColor() {
    return Colors.grey.withOpacity(0.2);
  }

  Color chatBubbleColor({bool isSent = false}) {
    if (isSent) {
      return Color.alphaBlend(accentColor().withOpacity(isDark ? 0.07 : 0.2), tertiaryColor());
    } else {
      return Colors.green.shade100;
    }
  }

  Color listItemColor({String? bgColor}) {
    if (hasBgColor(bgColor)) {
      return Colors.white.withOpacity(0.9);
    } else {
      return transparent;
    }
  }

  Color fileColor(String fileExtension) {
    if (['jpg', 'png', 'jpeg', 'jfif'].contains(fileExtension)) {
      return accentColor();
    } else if (['pdf'].contains(fileExtension)) {
      return Colors.redAccent;
    } else {
      return Colors.deepOrange;
    }
  }

  Color reminderOverviewColor([String? bgColor]) {
    if (hasBgColor(bgColor)) {
      return Colors.black12;
    } else {
      return isDark ? Colors.white10 : Colors.black12;
    }
  }

  // -------------------------- Shadows
  List<BoxShadow>? listItemShadow() {
    List<BoxShadow> shadow = [
      BoxShadow(
        color: Colors.grey.withOpacity(0.7),
        spreadRadius: 0.25,
        offset: Offset(0, 0.5),
      )
    ];

    return isDark || isImageTheme() ? null : shadow;
  }

  List<BoxShadow>? itemShadow([bool isHovered = true]) {
    return isDark
        ? null
        : [
            BoxShadow(
              color: isHovered ? Colors.grey.withOpacity(0.3) : transparent,
              spreadRadius: 1,
              blurRadius: 1.5,
              offset: Offset(0, 0),
            )
          ];
  }

  // -------------------------- Borders
  BoxBorder? itemBorder(bool isSelected, bool isHovered) {
    double w = (isDark ? 0.3 : 0.7);
    Color color = isImageTheme()
        ? transparent
        : isDark
            ? Colors.grey.withOpacity(isHovered ? 0.5 : 0.2)
            : Colors.grey.withOpacity(isHovered ? 0.7 : 0.4);
    return Border.all(color: isSelected ? accentColor() : color, width: w);
  }

  BorderSide lightTableBorder() {
    return BorderSide(
      color: Colors.grey.withOpacity(isDark ? 0.15 : (isImageTheme() ? 1 : 0.3)),
      width: isImageTheme() ? 1.5 : (isDark ? 0.7 : 1),
    );
  }

  Color? getItemColor(String? bgColor, bool isHovered, {bool isShadeColor = false}) {
    if (bgColor != null && bgColor.isNotEmpty && bgColor != 'x') {
      return isShadeColor ? backgroundColors[bgColor]!.shadeColor : backgroundColors[bgColor]!.color;
    } else {
      return isImageTheme()
          ? white.withOpacity(isHovered ? 0.12 : 0.1)
          : isBlackTheme()
              ? black
              : isDark
                  ? Color(0xff272829)
                  : transparent;
    }
  }

  // -------------------------- Box Decorations
  BoxDecoration itemBoxDecoration(bool isSelected, bool isHovered, String bgColor) {
    return BoxDecoration(
      color: getItemColor(bgColor, isHovered),
      border: itemBorder(isSelected, isHovered),
      borderRadius: BorderRadius.circular(borderRadiusSmall),
    );
  }
}
