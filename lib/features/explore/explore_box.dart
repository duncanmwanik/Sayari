import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';

class ExploreBox extends StatelessWidget {
  const ExploreBox({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.iconColor = Colors.red,
    required this.onPressed,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Color.alphaBlend(iconColor.withOpacity(0.1), styler.getItemColor('', false, isShadeColor: true)!),
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.withOpacity(styler.isDark ? 0.05 : 0.4), width: styler.isDark ? 0.3 : 0.7),
        borderRadius: BorderRadius.circular(borderRadiusSmall),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(borderRadiusSmall),
        hoverColor: iconColor.withOpacity(0.3),
        child: Container(
          padding: EdgeInsets.all(15),
          width: isTabAndBelow() ? 47.5.w : 30.w,
          constraints: BoxConstraints(minHeight: 160, maxWidth: 300),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // icon
              AppIcon(icon, size: 40, color: iconColor),
              //
              sph(),
              // title
              Flexible(child: AppText(size: normal, text: title, fontWeight: FontWeight.bold)),
              //
              sph(),
              // description
              Flexible(child: AppText(size: small, text: subtitle, faded: true)),
              //
            ],
          ),
        ),
      ),
    );
  }
}
