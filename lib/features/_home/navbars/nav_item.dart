import 'package:flutter/material.dart';

import '../../../_helpers/navigation.dart';
import '../../../_providers/_providers.dart';
import '../../../_theme/breakpoints.dart';
import '../../../_theme/helpers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/svg.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/go_to_view.dart';

Widget navItem(dynamic icon, String type, {double? size, Function()? onPressed}) {
  bool isSelected = state.views.view == type;

  return Stack(
    children: [
      // nav item
      AppButton(
        onPressed: onPressed ?? () => goToView(type),
        tooltip: getNavigationItemTitle(type.title()),
        tooltipDirection: isSmallPC() ? AxisDirection.right : AxisDirection.up,
        noStyling: true,
        color: styler.appColor(isDark() ? 1 : 2),
        padding: pad(p: isSmallPC() ? 8 : 12),
        child: SizedBox(
          width: 19,
          height: 19,
          child: type.isCalendar()
              ? AppButton(
                  padding: noPadding,
                  color: styler.textColor(faded: true),
                  borderRadius: 2,
                  child: Center(
                      child: AppText(
                    text: DateTime.now().day.toString(),
                    size: 11,
                    bold: true,
                    color: styler.invertedTextColor(),
                  )),
                )
              : icon.runtimeType == String
                  ? AppSvg(icon, size: size ?? 19, faded: true)
                  : AppIcon(icon, size: size ?? 19, faded: true),
        ),
      ),
      // selected indicator
      if (isSelected)
        Positioned(
          bottom: !isSmallPC() ? 0 : 11,
          left: !isSmallPC() ? 17 : null,
          child: AppButton(
            width: !isSmallPC() ? 8 : 3,
            height: !isSmallPC() ? 3 : 11,
            padding: noPadding,
            color: styler.accent,
          ),
        )
      //
    ],
  );
}
