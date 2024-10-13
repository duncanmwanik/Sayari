import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../_models/item.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/checkbox.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';

class QuickTaskItem extends StatelessWidget {
  const QuickTaskItem({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      child: Row(
        children: [
          AppCheckBox(isChecked: false),
          mpw(),
          AppText(text: item.title()),
          mpw(),
          AppButton(
            onPressed: () {},
            child: AppIcon(Icons.close),
          )
        ],
      ),
    );
  }
}
