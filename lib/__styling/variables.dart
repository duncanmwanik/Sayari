import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'styler.dart';

AppStyles styler = AppStyles();

Map<String, String> themeImages = {
  'light': 'light',
  'dark': 'dark',
  'black': 'dark',
  'mars': 'dark',
  'range': 'dark',
  'mountain': 'dark',
};

// sizes
const double webMaxWidthPlus = 868.0;
const double webMaxWidth = 768.0;
const double webMinWidth = 250.0;
const double webMaxSpaceManagerWidth = 300.0;
const double webMaxDialogWidth = 400.0;
const double webMinDialogWidth = 150;
const double webMinDialogHeight = 300;
const double webMaxButtonWidth = 300.0;
const double webMaxButtonHeight = 50.0;
const double webMaxListWidth = 200.0;
const double phoneWidth = 500;

// text sizes
const double pomodoroIcon = 50.0;
const double pomodoro = 30.0;
const double blogTitle = 24.0;
const double title = 22.0;
const double large = 20.0;
const double extra = 18.0;
const double normal = 16.0;
const double medium = 14.0;
const double mediumSmall = 13.0;
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
const Color white = Colors.white;

const List<IconData> toastIcons = [Icons.info_rounded, Icons.check_circle_rounded, Icons.info_rounded, Icons.info_rounded];
const List<Color> toastColors = [Colors.red, Colors.green, Colors.blue, Colors.pink];

// icons
const IconData sessionsSelectedIcon = FontAwesomeIcons.solidCalendar;
const String notesSelectedIcon = 'note-sticky-solid';
const String chatSelectedIcon = 'comment-solid';
const String exploreSelectedIcon = 'compass-solid';
const String codeSelectedIcon = 'code';
const IconData savedSeledctedIcon = Icons.bookmark_rounded;
const String datePlusSvg = 'calendar-plus-regular';
const String syncSvg = 'rotate-solid';
const String dropDownSvg = 'dropdown';

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
const IconData restoreIcon = Icons.arrow_upward_rounded;

const EdgeInsets zeroPadding = EdgeInsets.zero;
