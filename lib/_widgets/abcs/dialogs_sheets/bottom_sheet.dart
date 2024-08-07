import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/helpers.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_providers/providers.dart';
import '../../../_variables/navigation.dart';
import '../../others/others/divider.dart';

Future<void> showAppBottomSheet({
  Widget? header,
  required Widget content,
  Widget? footer,
  bool isShort = false,
  bool isMinimized = false,
  bool isFull = false,
  bool noContentHorizontalPadding = false,
  FutureOr<void> Function()? whenComplete,
  FutureOr<dynamic> Function(dynamic)? then,
}) async {
  // we record that the bottom sheet is open
  state.global.updateIsBottomSheetOpen(true);
  changeStatusAndNavigationBarColor(getThemeType(), isSecondary: true);

  await showModalBottomSheet(
      context: navigatorState.currentContext!,
      isScrollControlled: true,
      useSafeArea: true,
      constraints: isFull
          ? BoxConstraints.expand()
          : BoxConstraints(
              maxHeight: isShort ? 70.h : double.infinity,
              maxWidth: webMaxWidth / (isMinimized ? 1.5 : 1),
            ),
      elevation: 0,
      backgroundColor: transparent,
      //
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              if (!isFull && showFloatingSheet())
                GestureDetector(onTap: () => popWhatsOnTop(), child: Container(height: 50, color: transparent)),
              //
              Flexible(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ClipRRect(
                    borderRadius: isFull
                        ? BorderRadius.zero
                        : isShort
                            ? BorderRadius.only(
                                topLeft: Radius.circular(borderRadiusMedium),
                                topRight: Radius.circular(borderRadiusMedium))
                            : showFloatingSheet()
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
                              : isShort
                                  ? BorderRadius.only(
                                      topLeft: Radius.circular(borderRadiusMedium),
                                      topRight: Radius.circular(borderRadiusMedium))
                                  : showFloatingSheet()
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
                            isMinimized
                                ? Flexible(
                                    child: Padding(
                                    padding: noContentHorizontalPadding
                                        ? EdgeInsets.zero
                                        : EdgeInsets.symmetric(horizontal: isPhone() ? 10 : 20),
                                    child: content,
                                  ))
                                : Expanded(
                                    child: Padding(
                                    padding: noContentHorizontalPadding
                                        ? EdgeInsets.zero
                                        : EdgeInsets.symmetric(horizontal: isPhone() ? 10 : 20),
                                    child: content,
                                  )),
                            //
                            // Footer ----------
                            //
                            if (footer != null)
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AppDivider(height: 0),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                                    child: footer,
                                  ),
                                ],
                              )
                            //
                            //
                            //
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //
              if (!isFull && showFloatingSheet())
                GestureDetector(onTap: () => popWhatsOnTop(), child: Container(height: 50, color: transparent)),
              //
            ],
          ),
        );
      }).whenComplete(whenComplete ?? () {}).then(then ?? (_) {});

  changeStatusAndNavigationBarColor(getThemeType());
}
