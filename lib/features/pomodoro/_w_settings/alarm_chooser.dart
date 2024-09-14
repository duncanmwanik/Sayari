import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_widgets/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';

class AlarmChooser extends StatelessWidget {
  const AlarmChooser({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onPressed: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //
          AppText(text: 'Mockingbird'),
          mpw(),
          AppIcon(Icons.keyboard_arrow_down_rounded, size: normal),
          //
        ],
      ),
    );
  }
}
