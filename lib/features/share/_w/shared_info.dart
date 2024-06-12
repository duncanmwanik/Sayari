import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/images.dart';
import '../../../_widgets/others/text.dart';

class SharedItemInfo extends StatelessWidget {
  const SharedItemInfo({super.key, this.label});

  final String? label;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          mph(),
          AppImage(imagePath: 'assets/images/sayari.png', size: imageSizeSmall),
          lph(),
          Flexible(
              child: AppText(
            faded: true,
            text: label ?? "We couldn't find what you're looking for...",
            textAlign: TextAlign.center,
          )),
          mph(),
          AppButton(
            onPressed: () => context.go('/'),
            smallRightPadding: true,
            color: styler.accentColor(),
            borderRadius: borderRadiusCrazy,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(text: 'Explore Sayari', color: white, fontWeight: FontWeight.bold),
                spw(),
                AppIcon(Icons.arrow_forward_rounded, size: 16, color: white),
              ],
            ),
          ),
          //
          mph(),
          //
        ],
      ),
    );
  }
}
