import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/helpers.dart';
import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_providers/providers.dart';
import '../../../_variables/navigation.dart';
import '../../others/others/divider.dart';

Future<void> showAppBottomSheet({
  Widget? header,
  required Widget content,
  Widget? footer,
  bool isMinimized = false,
  bool isFull = false,
  bool noContentHorizontalPadding = false,
  FutureOr<void> Function()? whenComplete,
  FutureOr<dynamic> Function(dynamic)? then,
}) async {
  // we record that the bottom sheet is open
  state.global.updateIsBottomSheetOpen(true);
  changeStatusAndNavigationBarColor(getThemeType(), isSecondary: true);

  // showSheetAsDialog() : if screen is large, we show the sheet as a dialog look-alike

  await showModalBottomSheet(
      context: navigatorState.currentContext!,
      isScrollControlled: true,
      useSafeArea: true,
      constraints: isFull ? BoxConstraints.expand() : (isMinimized ? BoxConstraints(maxHeight: 70.h) : webMaxConstraints()),
      elevation: 0,
      backgroundColor: transparent,
      barrierColor: null,
      //
      //
      //
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              // dismiss bottom sheet : IGNORE!
              // works only with (color) defined
              if (showSheetAsDialog() && !isFull) GestureDetector(onTap: () => popWhatsOnTop(), child: Container(height: 50, color: transparent)),
              //
              //
              // ---------- Bottom Sheet starts here !
              //
              Expanded(
                child: ClipRRect(
                  borderRadius: isFull
                      ? BorderRadius.zero
                      : isMinimized
                          ? BorderRadius.only(topLeft: Radius.circular(borderRadiusMedium), topRight: Radius.circular(borderRadiusMedium))
                          : showSheetAsDialog()
                              ? BorderRadius.circular(borderRadiusMediumSmall)
                              : BorderRadius.zero,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                    child: Card(
                      elevation: 0,
                      color: (isImageTheme() || isBlackTheme() ? white.withOpacity(0.1) : styler.secondaryColor()),
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: isFull
                            ? BorderRadius.zero
                            : isMinimized
                                ? BorderRadius.only(topLeft: Radius.circular(borderRadiusMedium), topRight: Radius.circular(borderRadiusMedium))
                                : showSheetAsDialog()
                                    ? BorderRadius.circular(borderRadiusMediumSmall)
                                    : BorderRadius.zero,
                      ),
                      //
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //
                          // Header ----------
                          //
                          if (header != null)
                            Padding(
                              padding: EdgeInsets.only(top: 6, left: 6, right: 6),
                              child: header,
                            ),
                          //
                          // Content ----------
                          //
                          Expanded(
                              child: Padding(
                            padding: noContentHorizontalPadding ? EdgeInsets.zero : EdgeInsets.symmetric(horizontal: isPhone() ? 10 : 20),
                            child: content,
                          )),
                          //
                          // Footer ----------
                          //
                          if (footer != null) AppDivider(height: 0),
                          if (footer != null)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                              child: footer,
                            )
                          //
                          // ----------
                          //
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              //
              //
              // ---------- Bottom Sheet ends here !
              //
              // dismiss bottom sheet : IGNORE!
              // works only with (color) defined
              if (showSheetAsDialog() && !isFull) GestureDetector(onTap: () => popWhatsOnTop(), child: Container(height: 50, color: transparent)),
              //
              //
            ],
          ),
        );
      }).whenComplete(whenComplete ?? () {}).then(then ?? (_) {});

  changeStatusAndNavigationBarColor(getThemeType());
}
