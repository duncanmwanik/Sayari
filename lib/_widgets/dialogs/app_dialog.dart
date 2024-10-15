import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/helpers.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/navigation.dart';
import '../../_variables/navigation.dart';
import '../buttons/button.dart';
import '../others/icons.dart';
import '../others/others/other.dart';
import '../others/text.dart';

Future<dynamic> showAppDialog({
  dynamic title,
  Widget? content,
  List<Widget>? actions,
  EdgeInsets? contentPadding,
  bool showTitleColor = true,
  bool showClose = true,
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
                  constraints: BoxConstraints(maxWidth: maxWidth ?? (isPhone() ? double.infinity : webMaxDialogWidth), maxHeight: 70.h),
                  color: styler.secondaryColor().withOpacity(isImage() ? 0.4 : 0.8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //
                      if (title != null)
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            color: showTitleColor ? styler.appColor(isDark() ? 0.5 : 1) : null,
                            padding: paddingM(),
                            width: double.infinity,
                            child: Row(
                              children: [
                                Expanded(
                                  child: title.runtimeType == String ? HtmlText(text: title, color: styler.textColor()) : title,
                                ),
                                if (showClose)
                                  AppButton(
                                    onPressed: () => popWhatsOnTop(),
                                    margin: paddingS('l'),
                                    padding: paddingS(),
                                    isSquare: true,
                                    child: AppIcon(closeIcon, size: 16, faded: true),
                                  )
                              ],
                            ),
                          ),
                        ),
                      //
                      if (content != null)
                        Flexible(
                            child: Padding(
                          padding: contentPadding ?? paddingM(),
                          child: content,
                        )),
                      //
                      if (actions != null) tph(),
                      if (actions != null)
                        Padding(padding: paddingM(), child: Row(mainAxisAlignment: MainAxisAlignment.end, children: actions)),
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
