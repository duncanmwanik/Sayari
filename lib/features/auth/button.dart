import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/others/images.dart';
import '../../_widgets/others/loader.dart';
import '../../_widgets/others/text.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,
    required this.label,
    this.imagePath,
    required this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final String? imagePath;
  final Function() onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onPressed: onPressed,
      color: white,
      width: 210,
      height: 30,
      borderRadius: borderRadiusSmall,
      showBorder: !styler.isDark,
      dryWidth: true,
      child: isLoading
          ? AppLoader(color: styler.accentColor())
          : Row(
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
