import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/date_time/misc.dart';
import '../../../_providers/common/datetime.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';

class BookingDate extends StatelessWidget {
  const BookingDate({super.key, required this.availableDates});

  final List availableDates;
  @override
  Widget build(BuildContext context) {
    return Consumer<DateTimeProvider>(
      builder: (context, dateTime, child) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          AppButton(
            noStyling: true,
            smallRightPadding: true,
            borderRadius: borderRadiusSmall,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(Icons.calendar_month_rounded, size: 16, faded: true),
                spw(),
                AppText(text: 'Date', fontWeight: FontWeight.bold, faded: true),
                tpw(),
                AppText(text: ':', fontWeight: FontWeight.w900, faded: true),
                mpw(),
              ],
            ),
          ),
          //
          sph(),
          //
          if (availableDates.isNotEmpty)
            Flexible(
              child: Wrap(
                spacing: smallWidth(),
                runSpacing: smallWidth(),
                children: List.generate(availableDates.length, (index) {
                  return AppButton(
                    onPressed: () => dateTime.updateDateTime('date', availableDates[index]),
                    smallRightPadding: true,
                    borderRadius: borderRadiusSmall,
                    color: availableDates[index] == dateTime.date ? styler.accentColor() : null,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: AppText(
                      text: getDateFull(availableDates[index]),
                      color: availableDates[index] == dateTime.date ? white : null,
                    ),
                  );
                }),
              ),
            ),
          //
          //
          if (availableDates.isEmpty)
            AppButton(
              onPressed: () {},
              smallRightPadding: true,
              borderRadius: borderRadiusSmall,
              color: dateTime.date.isNotEmpty ? styler.accentColor() : null,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    text: dateTime.date.isNotEmpty ? getDateFull(dateTime.date) : 'Calendar',
                    color: dateTime.date.isNotEmpty ? white : null,
                  ),
                  if (dateTime.date.isEmpty) spw(),
                  if (dateTime.date.isEmpty) AppIcon(Icons.arrow_upward_rounded, size: 16, faded: true),
                ],
              ),
            ),
          //
        ],
      ),
    );
  }
}
