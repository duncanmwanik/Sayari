import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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

BoxConstraints webMaxConstraints() => kIsWeb ? const BoxConstraints(maxWidth: webMaxWidth) : const BoxConstraints();

// ---------- Paddings & Margins EdgeInsets

EdgeInsets itemMargin({bool? left, bool? right, bool? top, bool? bottom}) {
  return checkSpecificSide(5, left, right, top, bottom);
}

EdgeInsets itemMarginSmall({bool? left, bool? right, bool? top, bool? bottom}) {
  return checkSpecificSide(2.5, left, right, top, bottom);
}

EdgeInsets partitionPadding({bool? left, bool? right, bool? top, bool? bottom}) {
  return checkSpecificSide(8, left, right, top, bottom);
}

EdgeInsets itemPaddingLarge({bool? left, bool? right, bool? top, bool? bottom}) {
  return checkSpecificSide(15, left, right, top, bottom);
}

EdgeInsets itemPadding({bool? left, bool? right, bool? top, bool? bottom}) {
  return checkSpecificSide(13, left, right, top, bottom);
}

EdgeInsets itemPaddingMedium({bool? left, bool? right, bool? top, bool? bottom}) {
  return checkSpecificSide(7, left, right, top, bottom);
}

EdgeInsets itemPaddingSmall({bool? left, bool? right, bool? top, bool? bottom}) {
  return checkSpecificSide(4, left, right, top, bottom);
}

EdgeInsets checkSpecificSide(double p, bool? left, bool? right, bool? top, bool? bottom) {
  if (left != null || right != null || top != null || bottom != null) {
    return EdgeInsets.only(
      left: left == true ? p : 0,
      right: right == true ? p : 0,
      top: top == true ? p : 0,
      bottom: bottom == true ? p : 0,
    );
  } else {
    return EdgeInsets.all(p);
  }
}

// ---------- widths

double maxChatWidth() => isNotPhone() ? webMaxWidth : 75.w;
double largeWidth() => 32;
double mediumWidth() => 16;
double mediumSmallWidth() => 12;
double smallWidth() => 8;
double tinyWidth() => 4;

// ---------- heights

double extraLargeHeight() => 48;
double largeHeight() => 32;
double mediumHeight() => 16;
double mediumSmallHeight() => 12;
double smallHeight() => 8;
double tinySmallHeight() => 6;
double tinyHeight() => 4;
double largeHeightPlaceHolder() => 15.h;
double smallHeightPlaceHolder() => 10.h;

// ---------- quick sized boxes
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

Widget pw(double width) => SizedBox(width: width);
Widget tpw() => SizedBox(width: tinyWidth());
Widget spw() => SizedBox(width: smallWidth());
Widget mspw() => SizedBox(width: mediumSmallWidth());
Widget mpw() => SizedBox(width: mediumWidth());
Widget lpw() => SizedBox(width: largeWidth());
