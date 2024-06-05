import 'package:flutter/foundation.dart';
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
    tooltipDirection: AxisDirection.right,
    noStyling: !isSelected,
    color: showVertNav() ? null : styler.accentColor(1),
    showBorder: kIsWeb && isSelected,
    borderRadius: borderRadiusSmall,
    padding: EdgeInsets.all(showVertNav() ? 8 : 12),
    child: SizedBox(
      width: size ?? (showVertNav() ? 16 : 18),
      height: size ?? (showVertNav() ? 16 : 18),
      child: icon.runtimeType == String
          ? AppSvg(
              svgPath: icon,
              size: size ?? (showVertNav() ? 16 : 18),
              color: isSelected && !kIsWeb ? styler.accentColor() : null,
              faded: !isSelected,
            )
          : AppIcon(
              icon,
              size: size ?? (showVertNav() ? 16 : 18),
              color: isSelected&& !kIsWeb  ? styler.accentColor() : null,
              faded: !isSelected,
            ),
    ),
  );
}
