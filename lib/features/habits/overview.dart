import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../_models/item.dart';
import '../../_widgets/others/text.dart';
import '../calendar/_vars/date_time.dart';
import 'month.dart';
import 'progress_bar.dart';

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
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: paddingM('t'),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            HabitProgressBar(item: item),
            //
            HabitMonth(item: item),
            //
          ],
        ),
      ),
    );
  }
}
