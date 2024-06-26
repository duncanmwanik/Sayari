import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/_common/navigation.dart';
import '../../_helpers/date_time/date_info.dart';
import '../../_helpers/date_time/misc.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/abcs/dialogs_sheets/dialog_buttons.dart';
import '../../_widgets/abcs/dialogs_sheets/dialog_select_date.dart';
import '../../_widgets/others/others/divider.dart';
import '../../_widgets/others/svg.dart';
import '../../_widgets/others/text.dart';
import '../../_widgets/others/toast.dart';

List<Widget> reminderMenu({String? reminder, Function(String newReminder)? onSet, Function()? onRemove}) {
  // onBuildOperation(() => state.reminders.updateBothDateAndTime(reminder));
  // state.reminders.updateBothDateAndTime(reminder);

  return [MyWidget(reminder: reminder, onSet: onSet, onRemove: onRemove)];
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key, this.reminder, this.onSet, this.onRemove});

  final String? reminder;
  final Function(String newReminder)? onSet;
  final Function()? onRemove;

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String reminder = '';
  String date = '';
  String time = '';

  @override
  void initState() {
    setState(() {
      reminder = widget.reminder ?? '';
      if (reminder.isNotEmpty) {
        date = getDatePart(reminder);
        time = getTimePartFromDateTime(reminder);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool hasReminder = reminder.isNotEmpty;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                // date
                //
                AppButton(
                  onPressed: () async {
                    await showSelectDateDialog(initialDate: date).then((dates) {
                      if (dates.isNotEmpty) setState(() => date = getDatePart(dates.first));
                    });
                  },
                  borderRadius: borderRadiusSmall,
                  noStyling: true,
                  child: Padding(
                    padding: itemMarginSmall(),
                    child: Row(
                      children: [
                        AppSvg(svgPath: datePlusSvg, size: normal),
                        mpw(),
                        Flexible(
                          child: AppText(
                            text: date.isNotEmpty ? getDayInfoFullNames(date) : 'Select Date',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //
                AppDivider(height: smallHeight()),
                //
                // time
                //
                AppButton(
                  onPressed: () async {
                    await showTimePicker(
                      context: context,
                      initialTime: hasReminder ? TimeOfDay.fromDateTime(DateTime.parse(reminder)) : TimeOfDay.now(),
                      cancelText: 'Cancel',
                      confirmText: 'Done',
                    ).then((value) {
                      if (value != null) setState(() => time = (getTimePartFromTimeOfDay(value)));
                    });
                  },
                  borderRadius: borderRadiusSmall,
                  noStyling: true,
                  child: Padding(
                    padding: itemMarginSmall(),
                    child: Row(
                      children: [
                        AppSvg(svgPath: timePlusSvg, size: normal),
                        mpw(),
                        Flexible(
                          child: AppText(
                            text: time.isNotEmpty ? get12HourTimeFrom24HourTime(time, islonger: true) : 'Select Time',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //
              ],
            ),
          ),
          //
          AppDivider(height: smallHeight()),
          sph(),
          //
          Align(
            alignment: Alignment.bottomRight,
            child: Wrap(
              children: [
                //
                ActionButton(isCancel: true, label: 'Close'),
                //
                if (hasReminder)
                  ActionButton(
                    isCancel: true,
                    label: 'Remove',
                    onPressed: () {
                      popWhatsOnTop();
                      widget.onRemove!();
                    },
                  ),
                //
                ActionButton(
                  label: hasReminder ? 'Done' : 'Set',
                  onPressed: () {
                    if (date.isNotEmpty && time.isNotEmpty) {
                      popWhatsOnTop();
                      widget.onSet!('$date $time');
                    } else {
                      showToast(0, 'Choose a date and a time');
                    }
                  },
                ),
                //
              ],
            ),
          )
          //
        ],
      ),
    );
  }
}
