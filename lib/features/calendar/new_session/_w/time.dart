import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_helpers/navigation.dart';
import '../../../../_providers/input.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/text.dart';
import '../../_helpers/date_time/misc.dart';

class TimePicker extends StatelessWidget {
  const TimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      String startTime = get12HourTimeFrom24HourTime(input.item.data['s'], islonger: true);
      String stopTime = get12HourTimeFrom24HourTime(input.item.data['e'], islonger: true);
      bool hasStart = input.item.data['s'] != null && input.item.data['s'] != '';
      bool hasEnd = input.item.data['e'] != null && input.item.data['e'] != '';

      return Row(
        children: [
          //
          AppIcon(Icons.access_time, faded: true, size: 18),
          mpw(),
          //
          Flexible(
            child: Wrap(
              spacing: smallWidth(),
              runSpacing: smallWidth(),
              children: [
                //
                AppButton(
                    onPressed: () async {
                      hideKeyboard();
                      String time = hasStart ? input.item.data['s'] : '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}';
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
                        AppText(text: startTime),
                      ],
                    )),
                //
                AppButton(
                  noStyling: true,
                  isSquare: true,
                  child: AppIcon(Icons.arrow_forward, faded: true, size: normal),
                ),
                //
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //
                    AppButton(
                        onPressed: () async {
                          hideKeyboard();
                          String time = hasEnd ? input.item.data['e'] : '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}';
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
                            AppText(text: stopTime),
                          ],
                        )),
                    //
                    if (hasEnd) spw(),
                    if (hasEnd)
                      AppButton(
                        onPressed: () => input.remove('e'),
                        noStyling: true,
                        isSquare: true,
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
