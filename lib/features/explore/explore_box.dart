import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
      color: Color.alphaBlend(iconColor.withOpacity(0.2), styler.getItemColor('', false, isShadeColor: true)!),
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusSmall)),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(borderRadiusSmall),
        hoverColor: iconColor.withOpacity(0.3),
        child: Container(
          padding: EdgeInsets.all(15),
          width: 46.5.w,
          constraints: BoxConstraints(minHeight: 120, maxWidth: 260),
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
              Flexible(child: AppText(size: normal, text: title, weight: FontWeight.bold)),
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
