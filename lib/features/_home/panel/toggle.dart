import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/variables.dart';
import '../../../_providers/common/views.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/svg.dart';

class PanelToggle extends StatelessWidget {
  const PanelToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsProvider>(builder: (context, views, child) {
      return AppButton(
        onPressed: () => views.setShowWebBoxOptions(!views.showPanelOptions),
        noStyling: true,
        hoverColor: transparent,
        tooltip: views.showPanelOptions ? 'Collapse Panel' : 'Expand Panel',
        tooltipDirection: AxisDirection.right,
        child: AppSvg('panel', size: 22, faded: true),
      );
    });
  }
}
