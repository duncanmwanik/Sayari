import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_providers/providers.dart';
import '../abcs/buttons/buttons.dart';
import 'icons.dart';
import 'svg.dart';
import 'text.dart';

class EmptyBox extends StatelessWidget {
  const EmptyBox({
    super.key,
    this.icon = notesUnselectedIcon,
    this.label = 'Nothing here...',
    this.isSpaced = true,
    this.onPressed,
    this.size = imageSizeMedium,
  });

  final dynamic icon;
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
          icon.runtimeType == String
              ? AppSvg(svgPath: icon, size: size, faded: true)
              : AppIcon(icon, size: size, faded: true),
          //
          sph(),
          //
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppButton(
                onPressed: onPressed,
                noStyling: onPressed == null,
                child: AppText(
                  text:
                      '${state.views.isItemView() ? '${state.labels.selectedLabel}: ': ''}$label ',
                  faded: true,
                ),
              ),
            ],
          ),
          //
        ],
      ),
    );
  }
}
