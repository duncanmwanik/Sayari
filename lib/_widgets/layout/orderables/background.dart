import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../__styling/variables.dart';

Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
  return AnimatedBuilder(
    animation: animation,
    builder: (BuildContext context, Widget? child) {
      final double animValue = Curves.easeInOut.transform(animation.value);
      final double elevation = lerpDouble(0, 6, animValue)!;
      return Material(
        elevation: elevation,
        color: styler.primaryColor(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusMediumSmall)),
        shadowColor: transparent,
        child: child,
      );
    },
    child: child,
  );
}
