import 'package:flutter/material.dart';

import '../../../_theme/spacing.dart';
import '../../../_widgets/others/icons.dart';

class PanelPlaceholder extends StatelessWidget {
  const PanelPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: tinyWidth(),
      runSpacing: tinyWidth(),
      children: List.generate(100, (index) {
        return AppIcon(Icons.circle, size: 6, extraFaded: true);
      }),
    );
  }
}
