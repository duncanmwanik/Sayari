import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../abcs/buttons/buttons.dart';
import '../icons.dart';
import '../images.dart';
import '../text.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        elph(),
        //
        AppImage(imagePath: 'assets/images/sayari.png', size: imageSizeMedium),
        //
        mph(),
        //
        Flexible(child: AppText(size: onBoarding, text: 'Sayari', faded: true)),
        //
        sph(),
        //
        AppText(size: small, text: 'Version : 2.0.2', faded: true),
        //
        tph(),
        //
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //
            AppButton(onPressed: () {}, noStyling: true, smallVerticalPadding: true, child: AppText(size: small, text: 'Terms', faded: true)),
            tpw(),
            AppIcon(Icons.lens, size: 5),
            tpw(),
            AppButton(onPressed: () {}, noStyling: true, smallVerticalPadding: true, child: AppText(size: small, text: 'Privacy Policy', faded: true)),
            //
          ],
        ),
        //
        elph(),
        //
      ],
    );
  }
}
