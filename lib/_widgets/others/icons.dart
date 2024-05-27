import 'package:flutter/material.dart';

import '../../__styling/variables.dart';

class AppIcon extends StatelessWidget {
  const AppIcon(
    this.iconData, {
    super.key,
    this.color,
    this.size,
    this.tiny = false,
    this.faded = false,
    this.extraFaded = false,
    this.bgColor,
  });

  final IconData? iconData;
  final Color? color;
  final double? size;
  final bool tiny;
  final bool faded;
  final bool extraFaded;
  final String? bgColor;

  @override
  Widget build(BuildContext context) {
    return Icon(
      iconData,
      size: size ?? (tiny ? 18 : 20),
      color: color ?? styler.textColor(faded: faded, extraFaded: extraFaded, bgColor: bgColor),
      opticalSize: 5,
    );
  }
}
