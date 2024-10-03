import 'package:flutter/material.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_models/item.dart';
import '../../../../_widgets/others/text.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    bool isComplete = item.checkedCount() == item.taskCount();

    return Padding(
      padding: paddingM('b'),
      child: Visibility(
        visible: item.showChecks(),
        child: Padding(
          padding: paddingS('l'),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // count text
              AppText(
                text: '${item.checkedCount()} / ${item.taskCount()}',
                color: isComplete ? styler.accent : null,
                size: tinySmall,
                bgColor: item.color(),
                extraFaded: true,
              ),
              spw(),
              // bar
              SizedBox(
                height: medium,
                width: medium,
                child: CircularProgressIndicator(
                  value: item.checkedCount() / item.taskCount(),
                  backgroundColor: styler.accentColor(2),
                  valueColor: AlwaysStoppedAnimation(styler.accentColor()),
                  strokeCap: StrokeCap.round,
                  strokeWidth: 3,
                ),
              ),
              spw(),
              // percentage
              AppText(
                text: '${(item.checkedCount() / item.taskCount() * 100).truncate()}%',
                size: tinySmall,
                color: styler.accentColor(),
                weight: FontWeight.bold,
              ),
              //
            ],
          ),
        ),
      ),
    );
  }
}
