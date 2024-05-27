import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_helpers/_common/navigation.dart';
import '../../../../_helpers/date_time/misc.dart';
import '../../../../_providers/common/input.dart';
import '../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/svg.dart';
import '../../../../_widgets/others/text.dart';

class TimePicker extends StatelessWidget {
  const TimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      String startTime = get12HourTimeFrom24HourTime(input.data['s'], islonger: true);
      String stopTime = get12HourTimeFrom24HourTime(input.data['e'], islonger: true);

      return Row(
        children: [
          //
          AppSvg(svgPath: timePlusSvg, faded: true, size: 16),
          //
          spw(),
          //
          Flexible(
            child: Wrap(
              spacing: smallWidth(),
              children: [
                //
                AppButton(
                    onPressed: () async {
                      hideKeyboard();
                      String time = input.data['s'] != null && input.data['s'] != '' ? input.data['s'] : '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}';
                      TimeOfDay? startDayTime = await showTimePicker(context: context, cancelText: 'Cancel', confirmText: 'Done', initialTime: TimeOfDay(hour: getHour(time), minute: getMinute(time)));
                      if (startDayTime != null) {
                        input.update(action: 'add', key: 's', value: '${startDayTime.hour}:${startDayTime.minute}');
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppText(text: 'Starts at '),
                        AppText(text: startTime, fontWeight: FontWeight.w700),
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
                          String time = input.data['e'] != null && input.data['e'] != '' ? input.data['e'] : '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}';
                          TimeOfDay? stopDayTime =
                              await showTimePicker(context: context, cancelText: 'Cancel', confirmText: 'Done', initialTime: TimeOfDay(hour: getHour(time), minute: getMinute(time)));
                          if (stopDayTime != null) {
                            input.update(action: 'add', key: 'e', value: '${stopDayTime.hour}:${stopDayTime.minute}');
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppText(text: 'Ends at '),
                            AppText(text: stopTime, fontWeight: FontWeight.w700),
                          ],
                        )),
                    //
                    if (stopTime.isNotEmpty)
                      AppButton(
                        onPressed: () => input.update(action: 'remove', key: 'e'),
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
