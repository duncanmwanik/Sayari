import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../__styling/breakpoints.dart';
import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_providers/common/input.dart';
import '../../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/text.dart';
import '../_helpers/calculations.dart';
import '../_helpers/helpers.dart';
import '../graphs_sheet.dart';

class PeriodFooter extends StatelessWidget {
  const PeriodFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      return Row(
        children: [
          //
          AppButton(
            onPressed: () => showFinanceGraphsBottomSheet(),
            noStyling: true,
            smallLeftPadding: true,
            borderRadius: borderRadiusSmall,
            child: AppText(
                size: extra, text: 'Ksh. ${formatThousands(getTotalAmount('in'))}', color: Colors.green, fontWeight: FontWeight.w900),
          ),
          //
          spw(),
          AppText(size: extra, text: '|', faded: true),
          spw(),
          //
          AppButton(
            onPressed: () => showFinanceGraphsBottomSheet(),
            noStyling: true,
            smallLeftPadding: true,
            borderRadius: borderRadiusSmall,
            child:
                AppText(size: extra, text: 'Ksh. ${formatThousands(getTotalAmount('ex'))}', color: Colors.red, fontWeight: FontWeight.w900),
          ),
          //
          spw(),
          AppText(size: extra, text: '|', faded: true),
          spw(),
          //
          AppButton(
            onPressed: () => showFinanceGraphsBottomSheet(),
            noStyling: true,
            smallLeftPadding: true,
            borderRadius: borderRadiusSmall,
            child: AppText(
                size: extra, text: 'Ksh. ${formatThousands(getTotalAmount('sa'))}', color: Colors.blue, fontWeight: FontWeight.w900),
          ),
          //
          Spacer(),
          //
          if (isNotPhone())
            AppButton(
              onPressed: () => showFinanceGraphsBottomSheet(),
              tooltip: 'View Graphs',
              noStyling: true,
              isSquare: true,
              child: AppIcon(Icons.insert_chart_outlined_rounded, faded: true, size: 18),
            ),
          //
        ],
      );
    });
  }
}
