import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../abcs/buttons/buttons.dart';
import '../others/icons.dart';

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
      menuWidth: 20,
      noStyling: true,
      isRound: true,
      padding: itemPaddingSmall(),
      child: AppIcon(Icons.shopping_bag, faded: true, size: normal),
    );
  }
}
