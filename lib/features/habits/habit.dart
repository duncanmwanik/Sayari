import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_models/item.dart';
import '../../_providers/providers.dart';
import '_w/checked_dates.dart';
import '_w/header.dart';
import '_w/overview.dart';
import '_w/month.dart';
import '_w/week.dart';
import '_w/year.dart';

class Habit extends StatelessWidget {
  const Habit({super.key, this.item});
  final Item? item;

  @override
  Widget build(BuildContext context) {
    bool isInput = item == null;
    Map data = item != null ? item!.data : state.input.data;

    return Visibility(
      visible: data['ha'] != null,
      child: IgnorePointer(
        ignoring: !isInput,
        child: Container(
          margin: itemPadding(top: true, bottom: isInput),
          padding: itemPaddingMedium(),
          decoration: BoxDecoration(
            color: isInput ? styler.appColor(1) : null,
            borderRadius: BorderRadius.circular(borderRadiusSmall),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              if (isInput) HabitHeader(item: item),
              if (!isInput) HabitOverview(item: item, bgColor: data['c']),
              //
              if (isInput) sph(),
              //
              if (isInput) HabitWeek(item: item),
              if (isInput) HabitMonth(item: item),
              if (isInput) HabitYear(item: item),
              //
              if (isInput) CheckedDates(item: item),
              //
            ],
          ),
        ),
      ),
    );
  }
}
