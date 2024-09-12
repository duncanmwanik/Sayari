import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../__styling/spacing.dart';
import '../abcs/buttons/buttons.dart';
import 'images.dart';
import 'text.dart';

class EmptyBox extends StatelessWidget {
  const EmptyBox({
    super.key,
    this.label = 'Nothing here...',
    this.isSpaced = true,
    this.onPressed,
    this.size,
  });

  final String label;
  final bool isSpaced;
  final double? size;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            // if (isSpaced) spph(),
            // if (isSpaced) spph(),
            //
            AppImage(imagePath: 'assets/images/sayari.png', size: size ?? 15.h),
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
            // if (isSpaced) spph(),
            // if (isSpaced) spph(),
            //
          ],
        ),
      ),
    );
  }
}
