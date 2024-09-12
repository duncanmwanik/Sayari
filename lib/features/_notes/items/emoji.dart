import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';

class TaskEmoji extends StatelessWidget {
  const TaskEmoji({super.key, this.emoji});

  final String? emoji;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      menuItems: [
        //
        Wrap(
          spacing: smallWidth(),
          runSpacing: smallWidth(),
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.spaceAround,
          children: List.generate(25, (index) {
            return AppButton(
              onPressed: () {},
              noStyling: true,
              isSquare: true,
              child: AppIcon(Icons.lightbulb),
            );
          }),
        )
        //
      ],
      noStyling: true,
      isSquare: true,
      padding: EdgeInsets.all(4),
      child: AppIcon(Icons.lightbulb, color: styler.accent, size: normal),
    );
  }
}
