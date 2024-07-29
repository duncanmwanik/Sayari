import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_providers/common/views.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';

class PanelToggle extends StatelessWidget {
  const PanelToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsProvider>(builder: (context, views, child) {
      bool showWebBoxOptions = views.showWebBoxOptions;

      return AppButton(
        onPressed: () => views.setShowWebBoxOptions(!showWebBoxOptions),
        noStyling: true,
        isSquare: true,
        tooltip: showWebBoxOptions ? 'Collapse Panel' : 'Expand Panel',
        tooltipDirection: AxisDirection.right,
        child: AppIcon(
          showWebBoxOptions ? Icons.keyboard_double_arrow_left_rounded : Icons.keyboard_double_arrow_right_rounded,
          faded: true,
        ),
      );
    });
  }
}
