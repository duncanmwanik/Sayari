import 'package:flutter/material.dart';

import 'styler.dart';

AppStyles styler = AppStyles();

Map<String, String> themeImages = {
  'light': 'light',
  'dark': 'dark',
  'black': 'dark',
  'mars': 'dark',
  'jupiter': 'dark',
  'dune': 'dark',
  'night': 'dark',
  'range': 'dark',
  'mountain': 'dark',
};

// sizes
const double webMaxWidth = 768.0;
const double webMinWidth = 250.0;
const double webMaxTableManagerWidth = 300.0;
const double webMaxDialogWidth = 400.0;
const double webMaxDialogHeight = 500;
const double webMinDialogWidth = 150;
const double webMinDialogHeight = 300;
const double webMaxButtonWidth = 300.0;
const double webMaxButtonHeight = 50.0;
const double webMaxListWidth = 200.0;
const double webMaxToastWidth = 500.0;

// text sizes
const double pomodoroIcon = 50.0;
const double pomodoro = 30.0;
const double onBoarding = 24.0;
const double title = 22.0;
const double large = 20.0;
const double extra = 18.0;
const double normal = 16.0;
const double medium = 14.0;
const double small = 12.0;
const double tiny = 10.0;

// border radius sizes
const double borderRadiusSuperTiny = 3.0;
const double borderRadiusTiny = 5.0;
const double borderRadiusTinySmall = 7.0;
const double borderRadiusSmall = 10.0;
const double borderRadiusMediumSmall = 15.0;
const double borderRadiusMedium = 20.0;
const double borderRadiusLarge = 30.0;
const double borderRadiusCrazy = 200.0;

// image sizes
const double imageSizeTiny = 20.0;
const double imageSizeSmall = 80.0;
const double imageSizeMedium = 120.0;
const double imageSizeLarge = 200.0;

// global colors
const Color transparent = Colors.transparent;
const Color black = Colors.black;
const Color white = Color.fromARGB(255, 212, 186, 186);

const List<IconData> toastIcons = [Icons.info_rounded, Icons.check_circle_rounded, Icons.info_rounded, Icons.info_rounded];
const List<Color> toastColors = [Colors.red, Colors.green, Colors.blue, Colors.pink];

// icons
const String sessionsSelectedIcon = 'assets/icons/calendar-solid.svg';
const String sessionsUnselectedIcon = 'assets/icons/calendar-regular.svg';
const String notesSelectedIcon = 'assets/icons/note-sticky-solid.svg';
const String notesUnselectedIcon = 'assets/icons/note-sticky-regular.svg';
const String listsSelectedIcon = 'assets/icons/bulb-solid.svg';
const String listsUnselectedIcon = 'assets/icons/bulb-regular.svg';
const String financeSelectedIcon = 'assets/icons/dollar-sign-solid.svg';
const String financeUnselectedIcon = 'assets/icons/dollar-sign-regular.svg';
const String chatSelectedIcon = 'assets/icons/comment-solid.svg';
const String chatUnselectedIcon = 'assets/icons/comment-regular.svg';
const String exploreSelectedIcon = 'assets/icons/compass-solid.svg';
const String exploreUnSelectedIcon = 'assets/icons/compass-regular.svg';
const String codeSelectedIcon = 'assets/icons/code-solid.svg';
const String codeUnSelectedIcon = 'assets/icons/code-regular.svg';

const String datePlusSvg = 'assets/icons/calendar-plus-regular.svg';
const String timePlusSvg = 'assets/icons/clock-regular.svg';
const String timePlusSolidSvg = 'assets/icons/clock-solid.svg';
const String syncSvg = 'assets/icons/rotate-solid.svg';

const IconData pinIcon = Icons.push_pin_rounded;
const IconData unpinIcon = Icons.push_pin_outlined;
const IconData archiveIcon = Icons.archive_outlined;
const IconData unarchiveIcon = Icons.unarchive_outlined;
const IconData labelIcon = Icons.label_outlined;
const IconData reminderIcon = Icons.notifications_none_outlined;
const IconData colorIcon = Icons.palette_outlined;
const IconData moreIcon = Icons.more_horiz_rounded;
const IconData closeIcon = Icons.close_rounded;

const IconData deleteIcon = Icons.delete_outlined;
const IconData deleteForeverIcon = Icons.delete_forever_rounded;
const IconData restoreIcon = Icons.restore_from_trash_rounded;
 

// box decorations
  //  BoxDecoration(
  //       gradient: LinearGradient(
  //         begin: Alignment.topLeft,
  //         end: Alignment.bottomRight,
  //         colors: [Colors.white, Colors.orange],
  //       ),
  //     ),