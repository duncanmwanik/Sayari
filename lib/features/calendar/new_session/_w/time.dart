import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_helpers/_common/navigation.dart';
import '../../../../_helpers/date_time/misc.dart';
import '../../../../_providers/common/input.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/text.dart';

class TimePicker extends StatelessWidget {
  const TimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      String startTime = get12HourTimeFrom24HourTime(input.data['s'], islonger: true);
      String stopTime = get12HourTimeFrom24HourTime(input.data['e'], islonger: true);
      bool hasStart = input.data['s'] != null && input.data['s'] != '';
      bool hasEnd = input.data['e'] != null && input.data['e'] != '';

      return Row(
        children: [
          //
          AppIcon(Icons.access_time, faded: true, size: 18),
          mpw(),
          //
          Flexible(
            child: Wrap(
              spacing: smallWidth(),
              children: [
                //
                AppButton(
                    onPressed: () async {
                      hideKeyboard();
                      String time = hasStart ? input.data['s'] : '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}';
                      TimeOfDay? startDayTime = await showTimePicker(
                          context: context,
                          cancelText: 'Cancel',
                          confirmText: 'Done',
                          initialTime: TimeOfDay(hour: getHour(time), minute: getMinute(time)));
                      if (startDayTime != null) {
                        input.update('s', '${startDayTime.hour}:${startDayTime.minute}');
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!hasStart) AppText(text: 'Starts at'),
                        AppText(text: startTime, weight: FontWeight.bold),
                      ],
                    )),
                //
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //
                    AppButton(
                        onPressed: () async {
                          hideKeyboard();
                          String time = hasEnd ? input.data['e'] : '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}';
                          TimeOfDay? stopDayTime = await showTimePicker(
                              context: context,
                              cancelText: 'Cancel',
                              confirmText: 'Done',
                              initialTime: TimeOfDay(hour: getHour(time), minute: getMinute(time)));
                          if (stopDayTime != null) {
                            input.update('e', '${stopDayTime.hour}:${stopDayTime.minute}');
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!hasEnd) AppText(text: 'Ends at '),
                            AppText(text: stopTime, weight: FontWeight.bold),
                          ],
                        )),
                    //
                    if (hasEnd)
                      AppButton(
                        onPressed: () => input.remove('e'),
                        noStyling: true,
                        child: AppIcon(closeIcon, size: 14),
                      ),
                    //
                  ],
                ),
                //
              ],
            ),
          ),
          //
        ],
      );
    });
  }
}
