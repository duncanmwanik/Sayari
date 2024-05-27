import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../_variables/date_time.dart';
import '../../../_widgets/others/text.dart';

class MonthlyWeekdayLabels extends StatelessWidget {
  const MonthlyWeekdayLabels({super.key, this.isInitials = false});

  final bool isInitials;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: itemPaddingSmall(top: true),
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
                      padding: itemPaddingSmall(top: true, bottom: true),
                      child: AppText(
                        size: 10,
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
