import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/global.dart';
import '../../../_helpers/date_time/misc.dart';
import '../../../_providers/common/input.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/abcs/dialogs_sheets/dialog_select_date.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';

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
          //
          // ------------------------------ choose dates
          AppButton(
            onPressed: () async {
              await showSelectDateDialog(showTitle: true, isMultiple: true, initialDates: availableDates).then((chosenDates) {
                if (chosenDates.isNotEmpty) {
                  input.update(action: 'add', key: 'bd', value: getJoinedList(chosenDates));
                }
              });
            },
            noStyling: true,
            borderRadius: borderRadiusSmall,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(Icons.add_rounded, size: 18, faded: true),
                spw(),
                AppText(text: '${availableDates.isNotEmpty ? 'Edit' : 'Add'} Custom Dates'),
              ],
            ),
          ),
          //
          sph(), // ------------------------------ selected dates
          //
          availableDates.isNotEmpty
              ? Wrap(
                  runSpacing: 2,
                  children: List.generate(
                    availableDates.length,
                    (index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        child: AppButton(
                          borderRadius: borderRadiusSmall,
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppText(text: getDateFull(availableDates[index]), size: small, fontWeight: FontWeight.bold),
                              spw(),
                              AppButton(
                                onPressed: () {
                                  availableDates.remove(availableDates[index]);
                                  input.update(action: 'add', key: 'bd', value: getJoinedList(availableDates));
                                },
                                noStyling: true,
                                borderRadius: borderRadiusSmall,
                                child: AppIcon(Icons.close_rounded, size: 16),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Padding(
                  padding: itemPaddingLarge(left: true),
                  child: AppText(text: 'Clients can set their prefered date.', size: small, faded: true),
                ),
          //
          sph(), // ------------------------------ choose time
          //
          AppButton(
            onPressed: () async {
              TimeOfDay? time = await showTimePicker(context: context, cancelText: 'Cancel', confirmText: 'Add', initialTime: TimeOfDay.now());
              if (time != null) {
                availableTimes.add('${time.hour}:${time.minute}');
                input.update(action: 'add', key: 'bt', value: getJoinedList(availableTimes));
              }
            },
            noStyling: true,
            borderRadius: borderRadiusSmall,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(Icons.add_rounded, size: 18, faded: true),
                spw(),
                AppText(text: 'Add Custom Time'),
              ],
            ),
          ),
          //
          sph(), // ------------------------------ selected times
          //
          availableTimes.isNotEmpty
              ? Wrap(
                  runSpacing: 2,
                  children: List.generate(
                    availableTimes.length,
                    (index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        child: AppButton(
                          borderRadius: borderRadiusSmall,
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppText(text: get12HourTimeFrom24HourTime(availableTimes[index]), size: small, fontWeight: FontWeight.bold),
                              spw(),
                              AppButton(
                                onPressed: () {
                                  availableTimes.remove(availableTimes[index]);
                                  input.update(action: 'add', key: 'bt', value: getJoinedList(availableTimes));
                                },
                                noStyling: true,
                                borderRadius: borderRadiusSmall,
                                child: AppIcon(Icons.close_rounded, size: 16),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Padding(
                  padding: itemPaddingLarge(left: true),
                  child: AppText(text: 'Clients can set their prefered time.', size: small, faded: true),
                ),
          //
        ],
      );
    });
  }
}
