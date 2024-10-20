import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../_providers/_providers.dart';
import '../../../../../_theme/spacing.dart';
import '../../../../../_theme/variables.dart';
import '../../../../../_widgets/buttons/button.dart';
import '../../../../../_widgets/dialogs/dialog_select_date.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/text.dart';
import '../../../../calendar/_helpers/date_time/misc.dart';
import '../../../../calendar/state/datetime.dart';

class BookingDate extends StatelessWidget {
  const BookingDate({super.key, required this.availableDates});

  final List availableDates;
  @override
  Widget build(BuildContext context) {
    return Consumer<DateTimeProvider>(
      builder: (context, dateTime, child) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          AppButton(
            noStyling: true,
            srp: true,
            borderRadius: borderRadiusSmall,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(Icons.calendar_month_rounded, size: normal, faded: true),
                spw(),
                AppText(text: 'Date', weight: FontWeight.bold, faded: true),
                tpw(),
                AppText(text: ':', weight: FontWeight.w900, faded: true),
              ],
            ),
          ),
          //
          spw(),
          //
          if (availableDates.isNotEmpty)
            Flexible(
              child: Wrap(
                spacing: smallWidth(),
                runSpacing: smallWidth(),
                children: List.generate(availableDates.length, (index) {
                  return AppButton(
                    onPressed: () => dateTime.updateDateTime('date', availableDates[index]),
                    srp: true,
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
          if (availableDates.isEmpty)
            AppButton(
              onPressed: () =>
                  showDateDialog(title: 'Choose a Date', showTitle: true).then((date) => state.dateTime.updateDateTime('date', date.first)),
              srp: true,
              borderRadius: borderRadiusSmall,
              color: dateTime.date.isNotEmpty ? styler.accentColor() : null,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    text: dateTime.date.isNotEmpty ? getDateFull(dateTime.date) : 'Choose Date',
                    color: dateTime.date.isNotEmpty ? white : null,
                  ),
                  if (dateTime.date.isEmpty) spw(),
                  if (dateTime.date.isEmpty) AppIcon(Icons.arrow_forward_rounded, size: normal, faded: true),
                ],
              ),
            ),
          //
          if (availableDates.isEmpty && dateTime.date.isNotEmpty) spw(),
          if (availableDates.isEmpty && dateTime.date.isNotEmpty)
            AppButton(
              onPressed: () => showDateDialog(title: 'Select a date').then((date) => state.dateTime.updateDateTime('date', date.first)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(child: AppText(text: 'Change Date')),
                  spw(),
                  AppIcon(Icons.arrow_forward_rounded, size: normal, faded: true),
                ],
              ),
            ),
          //
        ],
      ),
    );
  }
}
