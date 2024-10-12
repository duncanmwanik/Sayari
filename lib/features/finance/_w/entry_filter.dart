import 'package:flutter/material.dart';

import '../../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/_providers.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../../../_widgets/others/svg.dart';
import '../../../_widgets/others/text.dart';

class EntriesFilter extends StatelessWidget {
  const EntriesFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      tooltip: 'Filter',
      menuItems: [
        //
        MenuItem(
          label: 'All',
          leading: Icons.all_inclusive,
          onTap: () => state.input.setEntryFilters('All'),
        ),
        //
        MenuItem(
          label: 'Income',
          leading: Icons.add,
          onTap: () => state.input.setEntryFilters('Income'),
        ),
        //
        MenuItem(
          label: 'Expenses',
          leading: Icons.remove,
          onTap: () => state.input.setEntryFilters('Expenses'),
        ),
        //
        MenuItem(
          label: 'Savings',
          leading: Icons.savings,
          onTap: () => state.input.setEntryFilters('Savings'),
        ),
        //
      ],
      isDropDown: true,
      smallVerticalPadding: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: AppText(text: state.input.filter)),
          spw(),
          AppSvg(dropDownSvg),
        ],
      ),
    );
  }
}
