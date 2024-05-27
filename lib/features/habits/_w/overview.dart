import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../_helpers/_common/global.dart';
import '../../../_models/item.dart';
import '../../../_variables/date_time.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import 'month.dart';
import 'week.dart';

class WeekLabels extends StatelessWidget {
  const WeekLabels({super.key, required this.width, this.bgColor});

  final double width;
  final String? bgColor;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 2,
      runSpacing: 2,
      children: List.generate(
        7,
        (index) => SizedBox(
          width: width / 8,
          child: AppText(
            size: 10,
            text: weekDaysList[index].superShortName,
            textAlign: TextAlign.center,
            faded: true,
            bgColor: bgColor,
          ),
        ),
      ),
    );
  }
}

class HabitOverview extends StatelessWidget {
  const HabitOverview({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    bool isCustom = item.data['hf'] == 'custom';
    int customDatesNo = (isCustom ? getSplitList(item.data['hd']) : []).length;
    int checkedNo = item.data.keys.where((key) => key.toString().startsWith('hc')).length;
    String view = item.data['hv'] ?? '0';

    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: itemPaddingSmall(bottom: true),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            sph(),
            //
            Row(
              children: [
                AppIcon(Icons.check_circle, size: 16, faded: true, bgColor: item.bgColor()),
                spw(),
                Flexible(child: AppText(text: 'Completed', bgColor: item.bgColor())),
                mpw(),
                AppText(
                    text: isCustom ? '$checkedNo / $customDatesNo' : '$checkedNo',
                    fontWeight: FontWeight.bold,
                    faded: true,
                    bgColor: item.bgColor()),
              ],
            ),
            //
            sph(),
            //
            if (view == '0') HabitWeek(item: item),
            if (view == '1' || view == '2') HabitMonth(item: item),
            //
          ],
        ),
      ),
    );
  }
}
