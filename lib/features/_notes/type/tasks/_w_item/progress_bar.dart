import 'package:flutter/material.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_models/item.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/text.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    bool isComplete = item.checkedCount() == item.taskCount();

    return Padding(
      padding: paddingM(),
      child: Row(
        children: [
          // icon
          AppIcon(
            Icons.check_circle,
            size: mediumSmall,
            color: isComplete ? styler.accent : null,
            bgColor: item.color(),
            extraFaded: true,
          ),
          spw(),
          // bar
          Expanded(
            child: LinearProgressIndicator(
              value: item.checkedCount() / item.taskCount(),
              borderRadius: BorderRadius.circular(borderRadiusSmall),
              backgroundColor: styler.accentColor(2),
              valueColor: AlwaysStoppedAnimation(styler.accentColor()),
            ),
          ),
          spw(),
          // count text
          AppText(
            text: '${item.checkedCount()} / ${item.taskCount()}',
            color: isComplete ? styler.accent : null,
            size: tiny,
            bgColor: item.color(),
            extraFaded: true,
          ),
        ],
      ),
    );
  }
}
