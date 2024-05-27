import 'package:flutter/material.dart';

import '../../../__styling/helpers.dart';
import '../../../__styling/variables.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key, this.thickness, this.height, this.color});

  final double? thickness;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? Colors.grey,
      thickness: thickness ?? (styler.isDark && !isImageTheme() ? 0.08 : 0.13),
      height: height,
    );
  }
}
