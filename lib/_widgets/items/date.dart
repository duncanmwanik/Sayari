import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/date_time/date_info.dart';
import '../../_helpers/date_time/misc.dart';
import '../../_providers/common/input.dart';
import '../abcs/buttons/buttons.dart';
import '../abcs/dialogs_sheets/dialog_select_date.dart';
import '../others/icons.dart';
import '../others/text.dart';

class Dates extends StatelessWidget {
  const Dates({super.key, this.showIcon = true});

  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      String startDate = getDayInfoFullNames(input.data['j'] ?? '');
      String endDate = getDayInfoFullNames(input.data['k'] ?? '');

      return Visibility(
        visible: input.data['h'] != '1',
        child: Padding(
          padding: itemPaddingSmall(bottom: true),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              if (showIcon) AppIcon(Icons.calendar_month_rounded, faded: true, size: 18),
              if (showIcon) spw(),
              //
              Flexible(
                child: Wrap(
                  spacing: smallWidth(),
                  runSpacing: smallWidth(),
                  children: [
                    //
                    AppButton(
                      onPressed: () async {
                        await showSelectDateDialog(initialDate: input.data['j']).then((date) async {
                          if (date.isNotEmpty) {
                            input.update(action: 'add', key: 'j', value: getDatePart(date.first));
                          }
                        });
                      },
                      smallRightPadding: startDate.isNotEmpty && showIcon,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppText(text: 'Starts on '),
                          Flexible(
                            child: AppText(
                              text: startDate != '' ? startDate : '...',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          //
                          if (startDate.isNotEmpty && showIcon) mpw(),
                          if (startDate.isNotEmpty && showIcon)
                            AppButton(
                              onPressed: () => input.update(action: 'remove', key: 'j'),
                              padding: EdgeInsets.all(2),
                              noStyling: true,
                              child: AppIcon(closeIcon, faded: true, size: 18),
                            ),
                          //
                        ],
                      ),
                    ),
                    //
                    AppButton(
                      onPressed: () async {
                        await showSelectDateDialog(initialDate: input.data['k']).then((date) async {
                          if (date.isNotEmpty) {
                            input.update(action: 'add', key: 'k', value: getDatePart(date.first));
                          }
                        });
                      },
                      smallRightPadding: endDate.isNotEmpty && showIcon,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(child: AppText(text: 'Ends on ')),
                          Flexible(
                            child: AppText(
                              text: endDate != '' ? endDate : '...',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          //
                          if (endDate.isNotEmpty && showIcon) mpw(),
                          if (endDate.isNotEmpty && showIcon)
                            AppButton(
                              onPressed: () => input.update(action: 'remove', key: 'k'),
                              padding: EdgeInsets.all(2),
                              noStyling: true,
                              child: AppIcon(closeIcon, faded: true, size: 18),
                            ),
                          //
                        ],
                      ),
                    ),
                    //
                  ],
                ),
              ),
              //
            ],
          ),
        ),
      );
    });
  }
}
