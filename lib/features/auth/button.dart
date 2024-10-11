import 'package:flutter/material.dart';

import '../../__styling/helpers.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/others/images.dart';
import '../../_widgets/others/loader.dart';
import '../../_widgets/others/text.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,
    required this.label,
    this.imagePath,
    required this.onPressed,
    this.isBusy = false,
  });

  final String label;
  final String? imagePath;
  final Function() onPressed;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onPressed: onPressed,
      height: 33,
      noStyling: true,
      showBorder: true,
      borderWidth: isDark() ? 0.4 : 0.8,
      child: isBusy
          ? Center(child: AppLoader(color: styler.accentColor()))
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (imagePath != null) AppImage(imagePath ?? '', size: normal),
                if (imagePath != null) spw(),
                Flexible(child: AppText(text: label)),
              ],
            ),
    );
  }
}
