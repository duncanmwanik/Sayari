import 'package:flutter/material.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_providers/_providers.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/text.dart';
import '../../_helpers/date_time/date_info.dart';

class SelectedDateChip extends StatelessWidget {
  const SelectedDateChip({super.key, required this.date});

  final String date;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      color: styler.appColor(1),
      padding: EdgeInsets.only(left: 10, top: 1, bottom: 1),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: AppText(size: small, text: getDayInfo(date))),
          tpw(),
          AppButton(
            onPressed: () => state.input.updateSelectedDates('remove', date: date),
            noStyling: true,
            isSquare: true,
            child: AppIcon(closeIcon, size: 14),
          ),
          //
        ],
      ),
    );
  }
}
