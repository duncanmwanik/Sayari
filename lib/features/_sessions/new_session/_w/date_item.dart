import 'package:flutter/material.dart';

import '../../../../__styling/variables.dart';
import '../../../../_helpers/date_time/date_info.dart';
import '../../../../_providers/providers.dart';
import '../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/text.dart';

class SelectedDateChip extends StatelessWidget {
  const SelectedDateChip({super.key, required this.date});

  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 1, bottom: 1),
      decoration: BoxDecoration(
        color: styler.appColor(1),
        borderRadius: BorderRadius.circular(borderRadiusMedium),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          Flexible(child: AppText(size: small, text: getDayInfo(date))),
          //
          AppButton(
            onPressed: () => state.input.updateSelectedDates('remove', date: date),
            noStyling: true,
            child: AppIcon(closeIcon, size: 14),
          ),
          //
        ],
      ),
    );
  }
}
