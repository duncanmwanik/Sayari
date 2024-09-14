import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_providers/common/views.dart';
import '../../_widgets/buttons/buttons.dart';
import '../../_widgets/others/svg.dart';
import '../../_widgets/others/text.dart';
import 'menu.dart';

class LabelSelector extends StatelessWidget {
  const LabelSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsProvider>(builder: (context, labels, child) {
      return AppButton(
        menuItems: labelsMenu(onDone: (newLabels) => labels.updateSelectedLabel(newLabels.first)),
        borderRadius: borderRadiusLarge,
        noStyling: true,
        borderWidth: 0.3,
        isDropDown: true,
        smallVerticalPadding: true,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: AppText(text: labels.selectedLabel)),
            spw(),
            AppSvg(dropDownSvg),
          ],
        ),
      );
    });
  }
}
