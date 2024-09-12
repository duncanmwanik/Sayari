import 'package:flutter/material.dart';

import '../../../__styling/helpers.dart';
import '../../../__styling/variables.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key, this.thickness, this.color, this.height});

  final double? thickness;
  final Color? color;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? Colors.grey,
      thickness: thickness ?? (styler.isDark && !isImageTheme() ? 0.08 : 0.1),
      height: height,
    );
  }
}
