import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../_helpers/_common/global.dart';
import 'breakpoints.dart';
import 'variables.dart';

int gridCount(double width) {
  if (width >= 1900) {
    return 8;
  } else if (width >= 1590) {
    return 7;
  } else if (width >= 1300) {
    return 6;
  } else if (width >= 1000) {
    return 5;
  } else if (width >= 780) {
    return 4;
  } else if (width >= 600) {
    return 3;
  } else {
    return 2;
  }
}

// ---------- paddings

EdgeInsets paddingL([String sides = 'ltrb']) => padding(s: sides, p: 16);
EdgeInsets paddingM([String sides = 'ltrb']) => padding(s: sides, p: 8);
EdgeInsets paddingS([String sides = 'ltrb']) => padding(s: sides, p: 4);
EdgeInsets padding({String s = 'lrtb', double p = 12, double? l, double? t, double? r, double? b}) {
  return EdgeInsets.only(
    left: l ?? (s.contains('l') ? p : 0),
    top: t ?? (s.contains('t') ? p : 0),
    right: r ?? (s.contains('r') ? p : 0),
    bottom: b ?? (s.contains('b') ? p : 0),
  );
}

EdgeInsets paddingC(String sides) {
  List pads = getSplitList(sides, separator: ',');
  return padding(
    l: double.tryParse(pads.firstWhere((p) => p.startsWith('l'), orElse: () => '00').substring(1)) ?? 0,
    t: double.tryParse(pads.firstWhere((p) => p.startsWith('t'), orElse: () => '00').substring(1)) ?? 0,
    r: double.tryParse(pads.firstWhere((p) => p.startsWith('r'), orElse: () => '00').substring(1)) ?? 0,
    b: double.tryParse(pads.firstWhere((p) => p.startsWith('b'), orElse: () => '00').substring(1)) ?? 0,
  );
}

// ---------- widths

double maxChatWidth() => isNotPhone() ? webMaxWidth : 75.w;
double largeWidth() => 32;
double mediumWidth() => 16;
double mediumSmallWidth() => 12;
double smallWidth() => 8;
double tinyWidth() => 4;

// ---------- heights

double largeHeightPlaceHolder() => 15.h;
double smallHeightPlaceHolder() => 10.h;
double extraLargeHeight() => 48;
double largeHeight() => 32;
double mediumHeight() => 16;
double mediumSmallHeight() => 12;
double smallHeight() => 8;
double tinySmallHeight() => 6;
double tinyHeight() => 4;

// ---------- quick sized boxes

// heights
Widget ph(double height) => SizedBox(height: height);
Widget tph() => SizedBox(height: tinyHeight());
Widget sph() => SizedBox(height: smallHeight());
Widget tsph() => SizedBox(height: tinySmallHeight());
Widget msph() => SizedBox(height: mediumSmallHeight());
Widget mph() => SizedBox(height: mediumHeight());
Widget lph() => SizedBox(height: largeHeight());
Widget elph() => SizedBox(height: extraLargeHeight());
Widget spph() => SizedBox(height: smallHeightPlaceHolder());
Widget lpph() => SizedBox(height: largeHeightPlaceHolder());
// widths
Widget pw(double width) => SizedBox(width: width);
Widget tpw() => SizedBox(width: tinyWidth());
Widget spw() => SizedBox(width: smallWidth());
Widget mspw() => SizedBox(width: mediumSmallWidth());
Widget mpw() => SizedBox(width: mediumWidth());
Widget lpw() => SizedBox(width: largeWidth());
