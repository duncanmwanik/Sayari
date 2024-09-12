import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_providers/common/input.dart';
import '../../../../_variables/features.dart';
import 'checked_dates.dart';
import 'month.dart';
import 'week.dart';
import 'year.dart';

class Habit extends StatelessWidget {
  const Habit({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      String view = input.data['hv'] ?? '0';

      return Visibility(
        visible: input.data[feature.habits.lt] != null,
        child: Container(
          margin: itemPadding(bottom: true),
          padding: itemPaddingMedium(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadiusSmall),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              if (view == '0') HabitWeek(),
              if (view == '1') HabitMonth(),
              if (view == '2') HabitYear(),
              //
              lph(),
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
