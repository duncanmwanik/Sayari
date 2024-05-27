import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/others/images.dart';
import '../../_widgets/others/text.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({super.key, required this.label, this.imagePath, required this.onPressed});

  final String label;
  final String? imagePath;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onPressed: onPressed,
      color: white,
      width: 220,
      height: 35,
      showBorder: !styler.isDark,
      dryWidth: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //
          if (imagePath != null) AppImage(imagePath: imagePath ?? '', size: imageSizeTiny),
          if (imagePath != null) spw(),
          Flexible(child: AppText(text: label, color: black, fontWeight: FontWeight.w600)),
          //
        ],
      ),
    );
  }
}
