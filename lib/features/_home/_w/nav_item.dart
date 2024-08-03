import 'package:flutter/material.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/svg.dart';
import '../_helpers/change_view.dart';

Widget navItem(dynamic icon, String type, bool isSelected, {double? size}) {
  return AppButton(
    onPressed: () => goToView(type),
    tooltip: getNavigationItemTitle(featureData[type]!.title),
    tooltipDirection: isSmallPC() ? AxisDirection.right : AxisDirection.up,
    noStyling: true,
    borderRadius: borderRadiusSmall,
    padding: EdgeInsets.all(isSmallPC() ? 8 : 12),
    child: SizedBox(
      width: size ?? (isSmallPC() ? 16 : 18),
      height: size ?? (isSmallPC() ? 16 : 18),
      child: icon.runtimeType == String
          ? AppSvg(
              svgPath: icon,
              size: size ?? (isSmallPC() ? 16 : 18),
              color: isSelected ? styler.accentColor() : null,
              faded: !isSelected,
            )
          : AppIcon(
              icon,
              size: size ?? (isSmallPC() ? 16 : 18),
              color: isSelected ? styler.accentColor() : null,
              faded: !isSelected,
            ),
    ),
  );
}
