import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_providers/_providers.dart';
import '../../../../_providers/input.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_theme/variables.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/text.dart';
import '../../../calendar/_helpers/date_time/date_info.dart';
import '../../../calendar/_helpers/date_time/misc.dart';

class CheckedDates extends StatelessWidget {
  const CheckedDates({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      Map data = input.item.data;
      List checkedDates = data.keys.where((key) => key.toString().startsWith('hc')).toList();
      bool isExpanded = input.item.data['ep'] == '1';

      return Column(
        children: [
          // hide/show checked dates
          Padding(
            padding: padding(s: 'tb'),
            child: AppButton(
              onPressed: () => input.update('ep', isExpanded ? '0' : '1'),
              noStyling: true,
              isSquare: true,
              hoverColor: transparent,
              padding: EdgeInsets.zero,
              child: Row(
                children: [
                  AppIcon(isExpanded ? Icons.visibility_off : Icons.visibility, size: normal, faded: true),
                  spw(),
                  AppText(text: '${isExpanded ? 'Hide' : 'Show'} checked dates', faded: true),
                ],
              ),
            ),
          ),
          mph(),
          // checked dates
          if (isExpanded)
            checkedDates.isNotEmpty
                ? Column(
                    children: List.generate(checkedDates.length, (index) {
                      String checkedDate = checkedDates[index];

                      return Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: AppButton(
                          onPressed: () {},
                          padding: paddingC('l8,t6,r4,b6'),
                          color: styler.appColor(1),
                          child: Row(
                            children: [
                              AppIcon(Icons.circle, size: small, color: styler.accent),
                              spw(),
                              Expanded(child: AppText(text: getDayInfoFullNames(checkedDate.substring(2)))),
                              AppIcon(Icons.check_circle, size: medium, extraFaded: true),
                              tpw(),
                              AppText(text: getEditDateTime(data[checkedDate]), extraFaded: true),
                              spw(),
                              AppButton(
                                onPressed: () => state.input.remove(checkedDate),
                                noStyling: true,
                                isSquare: true,
                                child: AppIcon(Icons.close, faded: true, size: normal),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  )
                : Center(child: AppText(text: 'Check dates to see them here', size: small, faded: true)),
          //
        ],
      );
    });
  }
}
