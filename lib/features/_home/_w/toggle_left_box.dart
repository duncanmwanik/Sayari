import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_providers/common/views.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';

class WebLeftBoxToggle extends StatelessWidget {
  const WebLeftBoxToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsProvider>(builder: (context, views, child) {
      bool showWebBoxOptions = views.showWebBoxOptions;

      return AppButton(
        onPressed: () => views.setShowWebBoxOptions(!showWebBoxOptions),
        noStyling: true,
        isSquare: true,
        tooltip: showWebBoxOptions ? 'Collapse Side Panel' : 'Expand Side Panel',
        tooltipDirection: AxisDirection.right,
        child: AppIcon(showWebBoxOptions ? Icons.keyboard_arrow_left_rounded : Icons.keyboard_arrow_right_rounded),
      );
    });
  }
}
