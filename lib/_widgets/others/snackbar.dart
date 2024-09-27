import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/variables.dart';
import '../../_helpers/navigation.dart';
import '../../_variables/navigation.dart';
import '../buttons/button.dart';
import 'icons.dart';
import 'toast.dart';

void showSnackBar(String message) {
  try {
    // we show the snackbar only for mobile size
    if (isPhone()) {
      ScaffoldMessenger.of(navigatorState.currentContext!).clearSnackBars();
      ScaffoldMessenger.of(navigatorState.currentContext!).showSnackBar(
        // TODOs: check for color
        SnackBar(
          padding: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
          content: Row(
            children: [
              // message
              Expanded(
                child: StyledText(
                  text: message,
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: medium),
                  tags: {
                    'b': StyledTextTag(style: const TextStyle(fontWeight: FontWeight.bold, fontSize: medium)),
                  },
                ),
              ),
              // close
              AppButton(
                onPressed: () => closeAllSnackBars(),
                noStyling: true,
                child: AppIcon(closeIcon, color: styler.invertedTextColor()),
              )
              //
            ],
          ),
        ),
      );
    } else {
      showToast(2, message);
    }
  } catch (_) {}
}
