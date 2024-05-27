import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../abcs/buttons/buttons.dart';
import 'icons.dart';
import 'text.dart';

void showToast(int type, String message, {int duration = 3, bool smallTopMargin = false}) {
  late CancelFunc cancel;

  void closeToast() => cancel();

  cancel = BotToast.showAttachedWidget(
    allowClick: true,
    target: Offset(0, 0),
    duration: Duration(seconds: duration),
    attachedBuilder: (_) => Align(
      alignment: isTabAndBelow() ? Alignment.topCenter : Alignment.topRight,
      child: Container(
        constraints: BoxConstraints(maxWidth: 380),
        margin: EdgeInsets.symmetric(
          horizontal: isTabAndBelow() ? 5.w : 15,
          vertical: isTabAndBelow() ? 10 : (smallTopMargin ? 15 : 60),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: styler.isDark ? Colors.white : Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: styler.itemShadow(),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            //
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: AppIcon(toastIcons[type], color: toastColors[type]),
            ),
            //
            mpw(),
            //
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: HtmlText(text: message, color: black),
            )),
            //
            spw(),
            //
            AppButton(
              onPressed: () => closeToast(),
              noStyling: true,
              padding: itemPaddingSmall(),
              child: AppIcon(Icons.close, color: Colors.black54, size: 18),
            ),
            //
          ],
        ),
      ),
    ),
  );
}
