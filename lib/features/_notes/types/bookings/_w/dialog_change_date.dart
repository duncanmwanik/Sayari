import 'package:flutter/material.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_helpers/_common/navigation.dart';
import '../../../../../_helpers/date_time/misc.dart';
import '../../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../../_widgets/abcs/dialogs_sheets/app_dialog.dart';
import '../../../../../_widgets/abcs/dialogs_sheets/dialog_buttons.dart';
import '../../../../../_widgets/abcs/dialogs_sheets/dialog_select_date.dart';
import '../../../../../_widgets/others/checkbox.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/others/divider.dart';
import '../../../../../_widgets/others/text.dart';

Future<void> showChangeBookingDateDialog({
  required String name,
  required String time,
  required String date,
  required Function(String newDate, String newTime, bool sendEmail) onDone,
}) async {
  await showAppDialog(
    //
    title: 'Change Date & Time',
    //
    content: Changer(name: name, date: date, time: time, onDone: onDone),
    //
  );
}

class Changer extends StatefulWidget {
  const Changer({super.key, required this.name, required this.date, required this.time, required this.onDone});
  final String name;
  final String date;
  final String time;
  final Function(String newDate, String newTime, bool sendEmail) onDone;

  @override
  State<Changer> createState() => _ChangerState();
}

class _ChangerState extends State<Changer> {
  String newDate = '';
  String newTime = '';
  bool sendEmail = true;

  @override
  void initState() {
    setState(() {
      newDate = widget.date;
      newTime = widget.time;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          AppButton(
            onPressed: () => showSelectDateDialog(
              title: 'Choose New Date',
              initialDate: newDate,
            ).then((dates) {
              if (dates.isNotEmpty) setState(() => newDate = dates.first);
            }),
            noStyling: true,
            borderRadius: borderRadiusSmall,
            child: Row(
              children: [
                AppIcon(Icons.edit_calendar_rounded, size: 16, faded: true),
                mpw(),
                AppText(text: getDateFull(newDate), fontWeight: FontWeight.bold, faded: true),
              ],
            ),
          ),
          //
          AppDivider(height: smallHeight()),
          //
          AppButton(
            onPressed: () async {
              await showTimePicker(
                context: context,
                cancelText: 'Cancel',
                confirmText: 'Done',
                initialTime: TimeOfDay(hour: 9, minute: 0),
              ).then((time) {
                if (time != null) {
                  setState(() => newTime = '${time.hour}:${time.minute}');
                }
                return null;
              });
            },
            noStyling: true,
            borderRadius: borderRadiusSmall,
            child: Row(
              children: [
                AppIcon(Icons.access_time_rounded, size: 16, faded: true),
                mpw(),
                AppText(text: get12HourTimeFrom24HourTime(newTime), fontWeight: FontWeight.bold, faded: true),
              ],
            ),
          ),
          //
          AppDivider(height: smallHeight()),
          //
          AppButton(
            onPressed: () => setState(() => sendEmail = !sendEmail),
            noStyling: true,
            borderRadius: borderRadiusSmall,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: HtmlText(text: 'Update <b>${widget.name}</b> on changes')),
                AppCheckBox(
                  isChecked: sendEmail,
                  onTap: () => setState(() => sendEmail = !sendEmail),
                ),
              ],
            ),
          ),
          //
          mph(),
          //
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ActionButton(isCancel: true),
              mpw(),
              ActionButton(
                label: 'Save',
                onPressed: () {
                  popWhatsOnTop();
                  widget.onDone(newDate, newTime, sendEmail);
                },
              ),
            ],
          ),
          //
        ],
      ),
    );
  }
}
