import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_providers/common/views.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/others/svg.dart';
import '../../_widgets/others/text.dart';
import 'labels_menu.dart';

class LabelSelector extends StatelessWidget {
  const LabelSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsProvider>(builder: (context, labels, child) {
      return AppButton(
        menuItems: labelsMenu(onDone: (newLabels) => labels.updateSelectedLabel(newLabels.first)),
        noStyling: true,
        borderRadius: borderRadiusLarge,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: AppText(text: labels.selectedLabel)),
            tpw(),
            AppSvg(svgPath: 'assets/icons/dropdown.svg'),
          ],
        ),
      );
    });
  }
}
