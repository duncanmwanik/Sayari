import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../_providers/_providers.dart';
import '../../../../../_providers/input.dart';
import '../../../../../_theme/breakpoints.dart';
import '../../../../../_theme/spacing.dart';
import '../../../../../_theme/variables.dart';
import '../../../../../_widgets/buttons/button.dart';
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
            slp: true,
            child: AppText(
                size: normal,
                text: 'Ksh. ${formatThousands(getTotalAmount(state.input.item, 'in'))}',
                color: Colors.green,
                weight: FontWeight.w900),
          ),
          //
          spw(),
          AppText(text: '|', extraFaded: true),
          spw(),
          //
          AppButton(
            onPressed: () => showFinanceGraphsBottomSheet(),
            noStyling: true,
            slp: true,
            child: AppText(
                size: normal,
                text: 'Ksh. ${formatThousands(getTotalAmount(state.input.item, 'ex'))}',
                color: Colors.red,
                weight: FontWeight.w900),
          ),
          //
          spw(),
          AppText(text: '|', extraFaded: true),
          spw(),
          //
          AppButton(
            onPressed: () => showFinanceGraphsBottomSheet(),
            noStyling: true,
            slp: true,
            child: AppText(
                size: normal,
                text: 'Ksh. ${formatThousands(getTotalAmount(state.input.item, 'sa'))}',
                color: Colors.blue,
                weight: FontWeight.w900),
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
