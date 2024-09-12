import 'package:flutter/material.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../_models/item.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/text.dart';
import '../_helpers/helpers.dart';

class FinanceOverview extends StatelessWidget {
  const FinanceOverview({super.key, required this.item});
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
              AppIcon(Icons.circle, size: 8, color: Colors.green),
              tpw(),
              AppText(text: 'Income    :', bold: true, bgColor: item.color()),
              tpw(),
              Flexible(
                child: AppText(
                  text: 'Ksh. ${formatThousands(item.totalIncome())}',
                  bgColor: item.color(),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          //
          sph(),
          //
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIcon(Icons.circle, size: 8, color: Colors.red),
              tpw(),
              AppText(text: 'Expenses:', bold: true, bgColor: item.color()),
              tpw(),
              Flexible(
                child: AppText(
                  text: 'Ksh. ${formatThousands(item.totalExpense())}',
                  bgColor: item.color(),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          //
          sph(),
          //
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIcon(Icons.circle, size: 8, color: Colors.blue),
              tpw(),
              AppText(text: 'Savings   :', bold: true, bgColor: item.color()),
              tpw(),
              Flexible(
                child: AppText(
                  text: 'Ksh. ${formatThousands(item.totalSavings())}',
                  bgColor: item.color(),
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
