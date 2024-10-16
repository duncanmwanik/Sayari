import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../_providers/views.dart';
import '../../../_widgets/others/icons.dart';

class PanelPlaceholder extends StatelessWidget {
  const PanelPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsProvider>(builder: (context, views, child) {
      return Wrap(
        spacing: tinyWidth(),
        runSpacing: tinyWidth(),
        children: List.generate(50, (index) {
          return AppIcon(Icons.circle, size: 6, extraFaded: true);
        }),
      );
    });
  }
}
