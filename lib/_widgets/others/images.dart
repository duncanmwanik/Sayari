import 'package:flutter/material.dart';

import '../../__styling/variables.dart';

class AppImage extends StatelessWidget {
  const AppImage({super.key, required this.imagePath, this.size = imageSizeLarge});

  final String imagePath;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      height: size,
      width: size,
      // filterQuality: FilterQuality.high,
    );
  }
}
