import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_variables/date_time.dart';
import '../../../_widgets/others/text.dart';

class MonthlyWeekdayLabels extends StatelessWidget {
  const MonthlyWeekdayLabels({super.key, this.isInitials = false});

  final bool isInitials;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: paddingS('t'),
      child: Row(
        children: List.generate(
          7,
          (index) => Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  child: Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(),
                    child: Padding(
                      padding: paddingS('tb'),
                      child: AppText(
                        size: isInitials ? tiny : small,
                        text: isInitials ? weekDaysList[index].superShortName : weekDaysList[index].shortName,
                        textAlign: TextAlign.center,
                        faded: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
