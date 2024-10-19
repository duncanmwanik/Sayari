import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_helpers/extentions/dateTime.dart';
import '../../../../_helpers/navigation.dart';
import '../../../../_providers/input.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/dialogs/dialog_select_date.dart';
import '../../../../_widgets/others/text.dart';
import '../../_helpers/date_time/date_info.dart';

class TimePicker extends StatelessWidget {
  const TimePicker({super.key, required this.type});
  final String type;

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      DateItem date = DateItem(input.item.data[type] ?? DateTime.now().toString());

      return Row(
        children: [
          //
          SizedBox(width: 40, child: AppText(text: type == 's' ? 'From:' : 'To:')),
          mpw(),
          //
          Flexible(
            child: Wrap(
              spacing: smallWidth(),
              runSpacing: smallWidth(),
              children: [
                // date
                AppButton(
                    onPressed: () async {
                      await showDateDialog(isMultiple: true, initialDates: input.selectedDates, showTitle: true).then((dates) async {
                        if (dates.isNotEmpty) {
                          input.update(type, '${dates.first} ${date.time24()}');
                        }
                      });
                    },
                    child: AppText(text: date.info())),
                // time
                AppButton(
                  onPressed: () async {
                    hideKeyboard();
                    TimeOfDay? time =
                        await showTimePicker(context: context, cancelText: 'Cancel', confirmText: 'Done', initialTime: date.time());
                    if (time != null) {
                      input.update(type, '${date.only()} ${time.to24Hrs()}');
                    }
                  },
                  child: AppText(text: date.time12()),
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
