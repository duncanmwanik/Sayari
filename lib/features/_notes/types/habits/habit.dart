import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_providers/input.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_theme/variables.dart';
import '../../../../_variables/features.dart';
import 'checked_dates.dart';
import 'month.dart';
import 'year.dart';

class Habit extends StatelessWidget {
  const Habit({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      String view = input.item.data['hv'] ?? '0';

      return Visibility(
        visible: input.item.data[feature.habits] != null,
        child: Container(
          margin: padN('b'),
          padding: padM(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadiusSmall),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              // if (view == '0') HabitWeek(),
              if (view == '0' || view == '1') HabitMonth(),
              if (view == '2') HabitYear(),
              //
              lph(),
              CheckedDates(),
              //
            ],
          ),
        ),
      );
    });
  }
}
