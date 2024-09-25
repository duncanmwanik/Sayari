import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/helpers.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/_common/navigation.dart';
import '../buttons/button.dart';
import '../others/others/divider.dart';

class Floater extends StatelessWidget {
  const Floater({
    super.key,
    this.header,
    required this.content,
    this.footer,
    this.isShort = false,
    this.isMinimized = false,
    this.isFull = false,
    this.showTopDivider = true,
    this.showBlur = false,
    this.noContentHorizontalPadding = false,
    this.whenComplete,
    this.then,
  });

  final Widget? header;
  final Widget content;
  final Widget? footer;
  final bool isShort;
  final bool isMinimized;
  final bool isFull;
  final bool showTopDivider;
  final bool showBlur;
  final bool noContentHorizontalPadding;
  final FutureOr<void> Function()? whenComplete;
  final FutureOr<dynamic> Function(dynamic)? then;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      child: AppButton(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          ? BorderRadius.only(topLeft: Radius.circular(borderRadiusSmall), topRight: Radius.circular(borderRadiusSmall))
                          : showFloatingSheet()
                              ? BorderRadius.circular(borderRadiusTinySmall)
                              : BorderRadius.zero,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                    child: Card(
                      elevation: 0,
                      color: (isImage() || isBlack() || showBlur ? white.withOpacity(0.1) : styler.secondaryColor()),
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: isFull
                            ? BorderRadius.zero
                            : isShort
                                ? const BorderRadius.only(
                                    topLeft: Radius.circular(borderRadiusSmall), topRight: Radius.circular(borderRadiusSmall))
                                : showFloatingSheet()
                                    ? BorderRadius.circular(borderRadiusTinySmall)
                                    : BorderRadius.zero,
                      ),
                      //
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          if (header != null) ph(5),
                          if (header != null && showTopDivider) AppDivider(),
                          //
                          // Content ----------
                          //
                          isMinimized
                              ? Flexible(
                                  child: Padding(
                                  padding: noContentHorizontalPadding ? noPadding : EdgeInsets.symmetric(horizontal: isPhone() ? 10 : 20),
                                  child: content,
                                ))
                              : Expanded(
                                  child: Padding(
                                  padding:
                                      noContentHorizontalPadding ? EdgeInsets.zero : EdgeInsets.symmetric(horizontal: isPhone() ? 10 : 20),
                                  child: content,
                                )),
                          //
                          // Footer ----------
                          //
                          if (footer != null)
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppDivider(),
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
      ),
    );
  }
}
