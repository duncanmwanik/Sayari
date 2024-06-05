import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/spacing.dart';
import '../../_providers/common/views.dart';
import '../../_variables/features.dart';
import '../../_variables/strings.dart';
import '../abcs/buttons/buttons.dart';
import '../others/icons.dart';

class LayoutButton extends StatelessWidget {
  const LayoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsProvider>(builder: (context, views, child) {
      bool showLayoutButton =
          views.isView(feature.notes.t) || views.isView(feature.notes.t) || views.isView(feature.finances.t);

      List layoutList = ['grid', 'row', 'column', 'list'];

      return Visibility(
        visible: showLayoutButton,
        child: Padding(
          padding: itemPadding(right: true),
          child: AppButton(
            onPressed: () {
              int index = layoutList.indexOf(views.layout);
              String newLayout = index == (layoutList.length - 1) ? layoutList[0] : layoutList[index + 1];
              views.setLayout(views.view, newLayout);
            },
            tooltip: 'Layout',
            isRound: true,
            noStyling: true,
            child: AppIcon(layoutIcons[views.layout] ?? Icons.lens, faded: true),
          ),
        ),
      );
    });
  }
}
