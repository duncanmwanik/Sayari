import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_helpers/date_time/date_info.dart';
import '../../../../_helpers/date_time/misc.dart';
import '../../../../_providers/common/input.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/others/divider.dart';
import '../../../../_widgets/others/text.dart';

class CheckedDates extends StatelessWidget {
  const CheckedDates({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      Map data = input.data;
      List checkedDates = data.keys.where((key) => key.toString().startsWith('hc')).toList();
      bool isExpanded = input.data['ep'] == '1';

      return Column(
        children: [
          //
          // hide/show checked dates
          Padding(
            padding: padding(s: 'tb'),
            child: AppButton(
              onPressed: () => input.update('ep', isExpanded ? '0' : '1'),
              noStyling: true,
              isSquare: true,
              hoverColor: transparent,
              padding: EdgeInsets.zero,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AppIcon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, faded: true),
                      tpw(),
                      AppText(text: '${isExpanded ? 'Hide' : 'Show'} checked dates', faded: true),
                    ],
                  ),
                  AppDivider(height: 0),
                ],
              ),
            ),
          ),
          //
          if (isExpanded)
            checkedDates.isNotEmpty
                ? Column(
                    children: List.generate(checkedDates.length, (index) {
                      String checkedDate = checkedDates[index];

                      return Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: AppButton(
                          onPressed: () {},
                          borderRadius: borderRadiusTiny,
                          smallLeftPadding: true,
                          noStyling: true,
                          child: Row(
                            children: [
                              AppIcon(Icons.circle, size: small, color: styler.accent),
                              spw(),
                              Expanded(child: AppText(text: getDayInfoFullNames(checkedDate.substring(2)))),
                              AppIcon(Icons.check_circle, size: medium, extraFaded: true),
                              tpw(),
                              AppText(text: getEditDateTime(data[checkedDate]), extraFaded: true),
                            ],
                          ),
                        ),
                      );
                    }),
                  )
                : Center(child: AppText(text: 'Check dates to see them here', size: small, faded: true)),
        ],
      );
    });
  }
}
