import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/date_time/date_info.dart';
import '../../../_helpers/date_time/misc.dart';
import '../../../_providers/common/input.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';

class CheckedDates extends StatelessWidget {
  const CheckedDates({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      Map data = input.data;
      List checkedDates = data.keys.where((key) => key.toString().startsWith('hc')).toList();
      bool isExpanded = data['hx'] == '1';

      return Padding(
        padding: itemPadding(top: true),
        child: Column(
          children: [
            //
            Align(
              alignment: Alignment.centerRight,
              child: AppButton(
                onPressed: () => input.update(action: 'add', key: 'hx', value: isExpanded ? '0' : '1'),
                noStyling: true,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(text: isExpanded ? 'Hide Details' : 'View Details'),
                    spw(),
                    AppIcon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 16, faded: true),
                  ],
                ),
              ),
            ),
            //
            sph(),
            //
            Visibility(
              visible: isExpanded,
              child: checkedDates.isNotEmpty
                  ? Column(
                      children: List.generate(checkedDates.length, (index) {
                        String checkedDate = checkedDates[index];

                        return Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: AppButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(text: getDayInfo(checkedDate.substring(2))),
                                Flexible(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      AppIcon(Icons.check_circle, size: 16, color: styler.accentColor()),
                                      tpw(),
                                      Flexible(child: AppText(text: getEditDateTime(data[checkedDate]))),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    )
                  : Center(child: AppText(text: 'Check dates to see them here', size: small, faded: true)),
            ),
          ],
        ),
      );
    });
  }
}
