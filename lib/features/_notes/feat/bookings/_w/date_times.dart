import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_helpers/_common/global.dart';
import '../../../../../_helpers/date_time/misc.dart';
import '../../../../../_providers/common/input.dart';
import '../../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../../_widgets/abcs/dialogs_sheets/dialog_select_date.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/text.dart';

class BookingDateTimes extends StatefulWidget {
  const BookingDateTimes({super.key});

  @override
  State<BookingDateTimes> createState() => _BookingState();
}

class _BookingState extends State<BookingDateTimes> {
  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      List<String> availableDates = getSplitList(input.data['bd']);
      List<String> availableTimes = getSplitList(input.data['bt']);

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
                  await showSelectDateDialog(showTitle: true, isMultiple: true, initialDates: availableDates)
                      .then((chosenDates) {
                    if (chosenDates.isNotEmpty) {
                      input.update(action: 'add', key: 'bd', value: getJoinedList(chosenDates));
                    }
                  });
                },
                color: styler.accentColor(1),
                borderRadius: borderRadiusCrazy,
                smallLeftPadding: true,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppIcon(Icons.add_rounded, tiny: true, faded: true),
                    tpw(),
                    AppText(text: 'Add Date'),
                  ],
                ),
              ),
              //
              for (String date in availableDates)
                AppButton(
                  borderRadius: borderRadiusCrazy,
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(text: getDateFull(date), size: small, fontWeight: FontWeight.bold),
                      spw(),
                      AppButton(
                        onPressed: () {
                          availableDates.remove(date);
                          input.update(action: 'add', key: 'bd', value: getJoinedList(availableDates));
                        },
                        noStyling: true,
                        isRound: true,
                        child: AppIcon(Icons.close_rounded, size: 16),
                      )
                    ],
                  ),
                ),
              //
              if (availableDates.isEmpty)
                AppText(text: 'Clients can set their prefered date.', size: small, faded: true),
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
                  TimeOfDay? time = await showTimePicker(
                      context: context, cancelText: 'Cancel', confirmText: 'Add', initialTime: TimeOfDay.now());
                  if (time != null) {
                    availableTimes.add('${time.hour}:${time.minute}');
                    input.update(action: 'add', key: 'bt', value: getJoinedList(availableTimes));
                  }
                },
                color: styler.accentColor(1),
                borderRadius: borderRadiusCrazy,
                smallLeftPadding: true,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppIcon(Icons.add_rounded, size: 18, faded: true),
                    tpw(),
                    AppText(text: 'Add Time'),
                  ],
                ),
              ),
              //
              for (String time in availableTimes)
                AppButton(
                  borderRadius: borderRadiusCrazy,
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(text: get12HourTimeFrom24HourTime(time), size: small, fontWeight: FontWeight.bold),
                      spw(),
                      AppButton(
                        onPressed: () {
                          availableTimes.remove(time);
                          input.update(action: 'add', key: 'bt', value: getJoinedList(availableTimes));
                        },
                        noStyling: true,
                        isRound: true,
                        child: AppIcon(Icons.close_rounded, size: 16),
                      )
                    ],
                  ),
                ),
              //
              if (availableTimes.isEmpty)
                AppText(text: 'Clients can set their prefered time.', size: small, faded: true),
              //
            ],
          ),
          //
        ],
      );
    });
  }
}
