import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_helpers/date_time/date_info.dart';
import '../../../../_helpers/date_time/misc.dart';
import '../../../../_providers/common/input.dart';
import '../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/text.dart';

class CheckedDates extends StatelessWidget {
  const CheckedDates({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      Map data = input.data;
      List checkedDates = data.keys.where((key) => key.toString().startsWith('hc')).toList();

      return checkedDates.isNotEmpty
          ? Column(
              children: List.generate(checkedDates.length, (index) {
                String checkedDate = checkedDates[index];

                return Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: AppButton(
                    onPressed: () {},
                    showBorder: true,
                    borderRadius: borderRadiusTiny,
                    smallLeftPadding: true,
                    noStyling: true,
                    child: Row(
                      children: [
                        AppIcon(Icons.check_box, color: styler.accent),
                        spw(),
                        Expanded(child: AppText(text: getDayInfoFullNames(checkedDate.substring(2)))),
                        AppIcon(Icons.access_time, size: 14, extraFaded: true),
                        tpw(),
                        AppText(text: getEditDateTime(data[checkedDate]), extraFaded: true),
                      ],
                    ),
                  ),
                );
              }),
            )
          : Center(child: AppText(text: 'Check dates to see them here', size: small, faded: true));
    });
  }
}
