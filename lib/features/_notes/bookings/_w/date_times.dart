import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_helpers/global.dart';
import '../../../../_providers/input.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/dialogs/dialog_select_date.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/text.dart';
import '../../../calendar/_helpers/date_time/misc.dart';

class BookingDateTimes extends StatelessWidget {
  const BookingDateTimes({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      List<String> availableDates = splitList(input.item.data['bd']);
      List<String> availableTimes = splitList(input.item.data['bt']);

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ------------------------------ selected dates
          Wrap(
            spacing: smallWidth(),
            runSpacing: smallWidth(),
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              //
              AppButton(
                onPressed: () async {
                  await showDateDialog(showTitle: true, isMultiple: true, initialDates: availableDates).then((chosenDates) {
                    if (chosenDates.isNotEmpty) {
                      input.update('bd', joinList(chosenDates));
                    }
                  });
                },
                color: styler.accentColor(1),
                smallLeftPadding: true,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppIcon(Icons.add_rounded, tiny: true, faded: true),
                    tpw(),
                    AppText(text: 'Add Date', size: small),
                  ],
                ),
              ),
              //
              for (String date in availableDates)
                AppButton(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(text: getDateFull(date), size: small, weight: FontWeight.bold),
                      spw(),
                      AppButton(
                        onPressed: () {
                          availableDates.remove(date);
                          input.update('bd', joinList(availableDates));
                        },
                        noStyling: true,
                        isRound: true,
                        child: AppIcon(Icons.close_rounded, size: 16),
                      )
                    ],
                  ),
                ),
              //
              if (availableDates.isEmpty) AppText(text: 'Set your prefered dates.', size: small, faded: true),
              //
            ],
          ),
          //
          sph(),
          // ------------------------------ selected times
          //
          Wrap(
            runSpacing: smallWidth(),
            spacing: smallWidth(),
            children: [
              //
              AppButton(
                onPressed: () async {
                  TimeOfDay? time =
                      await showTimePicker(context: context, cancelText: 'Cancel', confirmText: 'Add', initialTime: TimeOfDay.now());
                  if (time != null) {
                    availableTimes.add('${time.hour}:${time.minute}');
                    input.update('bt', joinList(availableTimes));
                  }
                },
                color: styler.accentColor(1),
                smallLeftPadding: true,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppIcon(Icons.add_rounded, size: 18, faded: true),
                    tpw(),
                    AppText(text: 'Add Time', size: small),
                  ],
                ),
              ),
              //
              for (String time in availableTimes)
                AppButton(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(text: get12HourTimeFrom24HourTime(time), size: small, weight: FontWeight.bold),
                      spw(),
                      AppButton(
                        onPressed: () {
                          availableTimes.remove(time);
                          input.update('bt', joinList(availableTimes));
                        },
                        noStyling: true,
                        isRound: true,
                        child: AppIcon(Icons.close_rounded, size: 16),
                      )
                    ],
                  ),
                ),
              //
              if (availableTimes.isEmpty) AppText(text: 'Set your prefered hours.', size: small, faded: true),
              //
            ],
          ),
          //
        ],
      );
    });
  }
}
