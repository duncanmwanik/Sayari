import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../__styling/variables.dart';
import '../../_services/hive/local_storage_service.dart';
import '../_providers/_providers.dart';
import '../_variables/colors.dart';
import 'styler.dart';

void changeStatusAndNavigationBarColor(String theme, {bool isSecondary = false}) {
  bool isDark = isDarkTheme(theme);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      //
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarColor: isSecondary
          ? styler.secondaryColor()
          : isImage()
              ? styler.appColor(0)
              : isBlack()
                  ? black
                  : isDark
                      ? AppColors.darkPrimary
                      : AppColors.lightPrimary,
      //
      systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: isSecondary
          ? styler.secondaryColor()
          : isImage()
              ? styler.appColor(7)
              : isBlack()
                  ? black
                  : isDark
                      ? AppColors.darkPrimary
                      : AppColors.lightPrimary,
      //
    ),
  );
}

bool isDark() => 'dark' == state.theme.themeType;
bool isDarkOnly() => 'dark' == state.theme.themeType && !isImage() && !isBlack();
bool isImage() => !['dark', 'light', 'black'].contains(state.theme.themeImage);
bool isBlack() => 'black' == state.theme.themeImage;

String getThemeImage(String themeImage, {bool isSmall = false}) {
  return 'assets/images/$themeImage${isSmall ? '_small' : ''}.jpg';
}

String getDefaultThemeImage() => getThemeImage(state.theme.themeImage);
String getThemeType() => settingBox.get('themeType', defaultValue: 'dark');
bool isDarkTheme(String theme) => theme == 'dark';

bool hasColour(String? bgColor) {
  if (bgColor == null || bgColor.isEmpty || !backgroundColors.containsKey(bgColor)) {
    return false;
  } else {
    return true;
  }
}

BoxDecoration getImageBackgroundDecoration() {
  return BoxDecoration(image: DecorationImage(image: AssetImage(getDefaultThemeImage()), fit: BoxFit.cover));
}
