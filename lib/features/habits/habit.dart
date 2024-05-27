import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_providers/common/input.dart';
import '../../_variables/features.dart';
import '_w/checked_dates.dart';
import '_w/header.dart';
import '_w/month.dart';
import '_w/week.dart';
import '_w/year.dart';

class Habit extends StatelessWidget {
  const Habit({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      String view = input.data['hv'] ?? '0';

      return Visibility(
        visible: input.data[feature.habits.lt] != null,
        child: Container(
          margin: itemPadding(top: true, bottom: true),
          padding: itemPaddingMedium(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadiusSmall),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              HabitHeader(),
              //
              mph(),
              //
              if (view == '0') HabitWeek(),
              if (view == '1') HabitMonth(),
              if (view == '2') HabitYear(),
              //
              CheckedDates(),
              //
            ],
          ),
        ),
      );
    });
  }
}
