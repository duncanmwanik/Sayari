import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/helpers.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/_common/navigation.dart';
import '../../_variables/navigation.dart';
import '../others/others/divider.dart';
import '../others/others/other.dart';
import '../others/text.dart';

Future<dynamic> showAppDialog({
  dynamic title,
  Widget? content,
  List<Widget>? actions,
  bool smallTitlePadding = false,
  bool showDivider = true,
  EdgeInsets? padding,
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
  double? maxWidth,
  Function? prep,
}) {
  // some logic before showing the dialog
  prep;
  hideKeyboard();

  return showGeneralDialog<dynamic>(
    context: navigatorState.currentContext!,
    transitionDuration: const Duration(milliseconds: 300),
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: styler.isDark ? Colors.black54 : Colors.black26,
    pageBuilder: (context, animation1, animation2) => const NoWidget(),
    transitionBuilder: (context, a1, a2, widget) {
      return Transform.scale(
        scale: a1.value,
        child: Opacity(
          opacity: a1.value,
          child: AlertDialog(
            backgroundColor: transparent,
            insetPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
            titlePadding: EdgeInsets.zero,
            actionsPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            //
            content: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadiusTinySmall),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                child: Container(
                  width: double.maxFinite,
                  padding: padding ?? paddingM(),
                  constraints: BoxConstraints(maxWidth: maxWidth ?? (isPhone() ? double.infinity : webMaxDialogWidth), maxHeight: 70.h),
                  color: white.withOpacity(isDark() ? 0.1 : 0.6),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: crossAxisAlignment,
                    children: [
                      //
                      if (title != null)
                        Align(
                          alignment: Alignment.topLeft,
                          child: title.runtimeType == String ? HtmlText(text: title, color: styler.textColor()) : title,
                        ),
                      //
                      if (title != null)
                        AppDivider(
                          height: smallTitlePadding ? tinyHeight() : mediumHeight(),
                          color: showDivider ? null : transparent,
                        ),
                      //
                      if (content != null) Flexible(child: content),
                      //
                      if (actions != null) mph(),
                      //
                      if (actions != null) Row(mainAxisAlignment: MainAxisAlignment.end, children: actions),
                      //
                    ],
                  ),
                ),
              ),
            ),
            //
          ),
        ),
      );
    },
  );
}
