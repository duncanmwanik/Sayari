import 'package:flutter/material.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/helpers.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/svg.dart';
import '../_helpers/change_view.dart';

Widget navItem(dynamic icon, String type, bool isSelected, {double? size, Function()? onPressed}) {
  return AppButton(
    onPressed: onPressed ?? () => goToView(type),
    tooltip: getNavigationItemTitle(features[type]!.title),
    tooltipDirection: isSmallPC() ? AxisDirection.right : AxisDirection.up,
    noStyling: !isSelected,
    color: styler.appColor(isDark() ? 1 : 2),
    borderRadius: borderRadiusSmall,
    padding: EdgeInsets.all(isSmallPC() ? 8 : 12),
    child: SizedBox(
      width: size ?? (isSmallPC() ? 16 : 18),
      height: size ?? (isSmallPC() ? 16 : 18),
      child: icon.runtimeType == String
          ? AppSvg(icon, size: size ?? (isSmallPC() ? 16 : 18), faded: true)
          : AppIcon(icon, size: size ?? (isSmallPC() ? 16 : 18), faded: true),
    ),
  );
}
