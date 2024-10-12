import 'package:flutter/material.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/helpers.dart';
import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/navigation.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/svg.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/go_to_view.dart';

Widget navItem(dynamic icon, String type, bool isSelected, {double? size, Function()? onPressed}) {
  bool isCalendar = feature.isCalendar(type);

  return Stack(
    children: [
      // nav item
      AppButton(
        onPressed: onPressed ?? () => goToView(type),
        tooltip: getNavigationItemTitle(features[type]!.title),
        tooltipDirection: isSmallPC() ? AxisDirection.right : AxisDirection.up,
        noStyling: !isSelected,
        color: styler.appColor(isDark() ? 1 : 2),
        padding: EdgeInsets.all(isSmallPC() ? 8 : 12),
        child: SizedBox(
          width: 19,
          height: 19,
          child: isCalendar
              ? Padding(
                  padding: padding(p: 1.5),
                  child: AppButton(
                    padding: noPadding,
                    color: styler.textColor(faded: true),
                    borderRadius: 2,
                    child: Stack(
                      children: [
                        Padding(
                          padding: paddingC('l1,r1,t1.5'),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              AppIcon(Icons.circle, size: isDark() ? 2 : 1, color: styler.invertedTextColor()),
                              AppIcon(Icons.circle, size: isDark() ? 2 : 1, color: styler.invertedTextColor()),
                            ],
                          ),
                        ),
                        Center(child: AppText(text: DateTime.now().day.toString(), size: 9, color: styler.invertedTextColor())),
                      ],
                    ),
                  ),
                )
              : icon.runtimeType == String
                  ? AppSvg(icon, size: size ?? 19, faded: true)
                  : AppIcon(icon, size: size ?? 19, faded: true),
        ),
      ),
      // selected indicator
      if (isSelected)
        Positioned(
          bottom: isPhone() ? 0 : 11,
          left: isPhone() ? 17 : null,
          child: AppButton(
            width: isPhone() ? 8 : 3,
            height: isPhone() ? 3 : 11,
            padding: noPadding,
            color: styler.accent,
          ),
        )
      //
    ],
  );
}
