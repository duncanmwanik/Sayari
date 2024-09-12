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
        const AppImage(imagePath: 'assets/images/sayari.png', size: 50),
        //
        spw(),
        //
        const Flexible(child: AppText(size: large, text: 'Sayari', faded: true, fontWeight: FontWeight.w800)),
        //
        sph(),
        //
        const AppText(size: small, text: 'Version: 2.0.2', faded: true),
        //
        tph(),
        //
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //
            AppButton(
                onPressed: () {},
                noStyling: true,
                smallVerticalPadding: true,
                child: const AppText(size: small, text: 'Terms', faded: true)),
            tpw(),
            const AppIcon(Icons.lens, size: 5),
            tpw(),
            AppButton(
                onPressed: () {},
                noStyling: true,
                smallVerticalPadding: true,
                child: const AppText(size: small, text: 'Privacy Policy', faded: true)),
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
