import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_helpers/date_time/misc.dart';
import '../../../../../_providers/common/datetime.dart';
import '../../../../../_widgets/buttons/buttons.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/text.dart';

class BookingTime extends StatelessWidget {
  const BookingTime({super.key, required this.availableTimes});

  final List availableTimes;

  @override
  Widget build(BuildContext context) {
    return Consumer<DateTimeProvider>(
      builder: (context, dateTime, child) => Row(
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
                AppIcon(Icons.access_time_rounded, size: 16, faded: true),
                spw(),
                AppText(text: 'Time', weight: FontWeight.bold, faded: true),
                tpw(),
                AppText(text: ':', weight: FontWeight.w900, faded: true),
              ],
            ),
          ),
          //
          spw(),
          //
          Wrap(
            spacing: smallWidth(),
            runSpacing: smallWidth(),
            children: List.generate(availableTimes.length, (index) {
              return AppButton(
                onPressed: () => dateTime.updateDateTime('time', availableTimes[index]),
                smallRightPadding: true,
                borderRadius: borderRadiusSmall,
                color: availableTimes[index] == dateTime.time ? styler.accentColor() : null,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: AppText(
                  text: get12HourTimeFrom24HourTime(availableTimes[index]),
                  color: availableTimes[index] == dateTime.time ? white : null,
                ),
              );
            }),
          ),
          //
          if (availableTimes.isEmpty && dateTime.time.isNotEmpty)
            AppButton(
              onPressed: () {},
              smallRightPadding: true,
              borderRadius: borderRadiusSmall,
              color: styler.accentColor(),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Center(
                  child: AppText(
                text: get12HourTimeFrom24HourTime(dateTime.time),
                color: white,
              )),
            ),
          //
          if (availableTimes.isEmpty && dateTime.time.isNotEmpty) spw(),
          //
          if (availableTimes.isEmpty)
            Flexible(
              child: AppButton(
                onPressed: () async {
                  await showTimePicker(
                    context: context,
                    cancelText: 'Cancel',
                    confirmText: 'Done',
                    initialTime: TimeOfDay(hour: 9, minute: 0),
                  ).then((time) {
                    if (time != null) {
                      dateTime.updateDateTime('time', '${time.hour}:${time.minute}');
                    }
                    return null;
                  });
                },
                smallRightPadding: true,
                borderRadius: borderRadiusSmall,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(child: AppText(text: dateTime.time.isNotEmpty ? 'Change Time' : 'Choose Time')),
                    spw(),
                    AppIcon(Icons.arrow_forward_rounded, size: 16, faded: true),
                  ],
                ),
              ),
            ),
          //
        ],
      ),
    );
  }
}
