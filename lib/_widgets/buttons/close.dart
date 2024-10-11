import 'package:flutter/material.dart';

import '../../__styling/variables.dart';
import '../../_helpers/navigation.dart';
import '../others/icons.dart';
import 'button.dart';

class AppCloseButton extends StatelessWidget {
  const AppCloseButton({
    super.key,
    this.onPressed,
    this.faded = false,
    this.isX = true,
  });

  final Function()? onPressed;
  final bool faded;
  final bool isX;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onPressed: onPressed ?? () => popWhatsOnTop(),
      noStyling: true,
      isSquare: true,
      child: AppIcon(isX ? closeIcon : Icons.arrow_back_rounded, faded: faded),
    );
  }
}
