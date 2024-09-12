import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../__styling/variables.dart';
import '../../../_variables/colors.dart';
import '../../../_widgets/others/text.dart';

class SessionWidgetMonthly extends StatelessWidget {
  const SessionWidgetMonthly({super.key, required this.sessionData});

  final Map sessionData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.1.w, vertical: 0.1.h),
      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadiusSuperTiny),
        color: backgroundColors[sessionData['c'] ?? '0']!.color,
      ),
      child: AppText(
        size: small,
        text: sessionData['t'],
        overflow: TextOverflow.clip,
        color: backgroundColors[sessionData['c'] ?? '0']!.textColor,
        maxlines: 1,
      ),
    );
  }
}
