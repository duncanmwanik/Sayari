import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../abcs/buttons/buttons.dart';
import 'images.dart';
import 'text.dart';

class EmptyBox extends StatelessWidget {
  const EmptyBox({
    super.key,
    this.label = 'Nothing here...',
    this.isSpaced = true,
    this.onPressed,
    this.size = imageSizeMedium,
  });

  final String label;
  final bool isSpaced;
  final double size;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          if (isSpaced) spph(),
          if (isSpaced) spph(),
          //
          AppImage(imagePath: 'assets/images/sayari-bw.png', size: imageSizeSmall),
          //
          sph(),
          //
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppButton(
                onPressed: onPressed,
                noStyling: onPressed == null,
                child: AppText(text: label, faded: true),
              ),
            ],
          ),
          //
        ],
      ),
    );
  }
}
