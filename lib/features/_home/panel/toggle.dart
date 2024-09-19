import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_providers/views.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';

class PanelToggle extends StatelessWidget {
  const PanelToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsProvider>(builder: (context, views, child) {
      return AppButton(
        onPressed: () => views.setShowWebBoxOptions(!views.showPanelOptions),
        tooltip: views.showPanelOptions ? 'Collapse Panel' : 'Expand Panel',
        tooltipDirection: AxisDirection.right,
        isSquare: true,
        noStyling: true,
        child: AppIcon(
          views.showPanelOptions ? Icons.keyboard_double_arrow_left : Icons.keyboard_double_arrow_right,
          faded: true,
        ),
      );
    });
  }
}
