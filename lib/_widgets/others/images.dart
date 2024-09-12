import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.imagePath,
    this.size,
    this.height,
    this.width,
    this.borderRadius = 0,
    this.fit = BoxFit.cover,
  });

  final String imagePath;
  final double? size;
  final double? height;
  final double? width;
  final double borderRadius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? size,
      width: width ?? size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        image: DecorationImage(image: AssetImage(imagePath), fit: fit),
      ),
    );
  }
}
