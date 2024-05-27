import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../_models/item.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/helpers.dart';

class PeriodOverview extends StatelessWidget {
  const PeriodOverview({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(text: 'Income    :', bgColor: item.bgColor()),
              tpw(),
              Flexible(
                child: AppText(
                  text: 'Ksh. ${formatThousands(item.totalIncome())}',
                  bgColor: item.bgColor(),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          //
          tph(),
          //
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(text: 'Expenses:', bgColor: item.bgColor()),
              tpw(),
              Flexible(
                child: AppText(
                  text: 'Ksh. ${formatThousands(item.totalExpense())}',
                  bgColor: item.bgColor(),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          //
          tph(),
          //
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(text: 'Savings   :', bgColor: item.bgColor()),
              tpw(),
              Flexible(
                child: AppText(
                  text: 'Ksh. ${formatThousands(item.totalSavings())}',
                  bgColor: item.bgColor(),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          //
        ],
      ),
    );
  }
}
