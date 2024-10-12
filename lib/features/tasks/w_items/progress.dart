import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_models/item.dart';
import '../../../_widgets/others/text.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingC('l4'),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // count
          Expanded(
              child: AppText(
            text: '${item.checkedCount()} / ${item.taskCount()}',
            size: tinySmall,
            faded: true,
            bgColor: item.color(),
          )),
          // progress
          SizedBox(
            height: small,
            width: small,
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
    );
  }
}
