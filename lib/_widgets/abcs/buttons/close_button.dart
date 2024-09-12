import 'package:flutter/material.dart';

import '../../../__styling/variables.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../others/icons.dart';
import '../../others/text.dart';
import 'buttons.dart';

class AppCloseButton extends StatelessWidget {
  const AppCloseButton({
    super.key,
    this.onPressed,
    this.faded = false,
    this.isX = false,
    this.isText = false,
  });

  final Function()? onPressed;
  final bool faded;
  final bool isX;
  final bool isText;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onPressed: onPressed ?? () => popWhatsOnTop(),
      noStyling: !isText,
      isSquare: true,
      child: isText
          ? const AppText(text: 'Close', size: medium, faded: true)
          : AppIcon(isX ? closeIcon : Icons.arrow_back_rounded, faded: faded),
    );
  }
}

//
//
//
