import 'package:flutter/material.dart';

import 'styler.dart';
import 'variables.dart';

class AppTheme {
  static ThemeData themeData(bool isDarkTheme) {
    return ThemeData(
      primaryColor: isDarkTheme ? AppColors.darkPrimary : AppColors.lightPrimary,
      scaffoldBackgroundColor: isDarkTheme ? AppColors.darkPrimary : AppColors.lightPrimary,
      cardColor: isDarkTheme ? AppColors.darkPrimary : AppColors.lightPrimary,
      canvasColor: isDarkTheme ? AppColors.darkPrimary : AppColors.lightPrimary,
      shadowColor: isDarkTheme ? AppColors.darkTextFaded : AppColors.lightTextFaded,
      hintColor: isDarkTheme ? AppColors.darkTextFaded : AppColors.lightTextFaded,
      highlightColor: isDarkTheme ? AppColors.darkHover : AppColors.lightHover,
      hoverColor: isDarkTheme ? AppColors.darkHover : AppColors.lightHover,
      focusColor: isDarkTheme ? AppColors.darkHover : AppColors.lightHover,
      disabledColor: isDarkTheme ? AppColors.darkTextFaded : AppColors.lightTextFaded,
      dialogTheme: DialogTheme(elevation: 0),
      timePickerTheme: TimePickerThemeData(
        elevation: 0,
        backgroundColor: isDarkTheme ? AppColors.darkSecondary : AppColors.lightSecondary,
        helpTextStyle: TextStyle(fontSize: small, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusMedium)),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: extra,
          color: isDarkTheme ? AppColors.darkText : AppColors.lightText,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: isDarkTheme ? AppColors.darkBottomNavBarColor : AppColors.lightBottomNavBarColor,
        elevation: isDarkTheme ? 1 : 6,
        foregroundColor: isDarkTheme ? AppColors.lightPrimary : AppColors.darkPrimary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isDarkTheme ? AppColors.darkPrimary : AppColors.lightPrimary,
          foregroundColor: AppColors.accentHoverButton,
          textStyle: TextStyle(fontSize: normal, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusTiny)),
          shadowColor: AppColors.transparent,
        ),
      ),
      dividerTheme: DividerThemeData(
        color: isDarkTheme ? AppColors.darkDividerColor : AppColors.lightDividerColor,
      ),
      fontFamily: 'Nunito',
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: AppColors.textSelectionColor,
        selectionHandleColor: AppColors.accent,
        cursorColor: AppColors.accent,
      ),
      iconTheme: IconThemeData(
        color: isDarkTheme ? AppColors.darkText : AppColors.lightText,
      ),
      tooltipTheme: TooltipThemeData(
        verticalOffset: 30,
        textStyle: TextStyle(color: Colors.black),
        decoration: BoxDecoration(
          color: AppColors.lightTertiary,
          borderRadius: BorderRadius.circular(borderRadiusTiny),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 1, blurRadius: 1.5)],
        ),
      ),
      primaryIconTheme: IconThemeData(color: isDarkTheme ? AppColors.lightTextFaded : AppColors.darkTextFaded),
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
    );
  }
}
