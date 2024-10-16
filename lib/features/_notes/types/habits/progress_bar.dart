import 'package:flutter/material.dart';

import '../../../../../_models/item.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/text.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_theme/variables.dart';

class HabitProgressBar extends StatelessWidget {
  const HabitProgressBar({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    bool isCustom = item.data['hf'] == 'custom';
    int customDateCount = item.customHabitDatesCount();
    int checkedCount = item.checkedHabitCount();
    bool isComplete = item.checkedHabitCount() == item.taskCount();

    return isCustom
        ? Row(
            children: [
              // icon
              AppIcon(
                Icons.check_circle,
                size: medium,
                color: isComplete ? styler.accent : null,
                bgColor: item.color(),
                faded: true,
              ),
              spw(),
              // bar
              Expanded(
                child: LinearProgressIndicator(
                  value: item.checkedHabitCount() / item.customHabitDatesCount(),
                  borderRadius: BorderRadius.circular(borderRadiusSmall),
                  backgroundColor: styler.accentColor(2),
                  valueColor: AlwaysStoppedAnimation(styler.accentColor()),
                ),
              ),
              spw(),
              // count text
              AppText(
                text: '$checkedCount / $customDateCount',
                color: isComplete ? styler.accent : null,
                bgColor: item.color(),
                faded: true,
              ),
            ],
          )
        : Row(
            children: [
              AppIcon(Icons.check_circle, size: medium, faded: true, bgColor: item.color()),
              tpw(),
              Flexible(child: AppText(text: 'Checked:', bgColor: item.color())),
              spw(),
              AppText(text: '$checkedCount', faded: true, bgColor: item.color()),
            ],
          );
  }
}
