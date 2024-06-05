import 'package:flutter/material.dart';

import '../../../../../../__styling/spacing.dart';
import '../../../../../_providers/providers.dart';
import '../../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../../_widgets/abcs/menu/menu_item.dart';
import '../../../../../_widgets/others/svg.dart';
import '../../../../../_widgets/others/text.dart';

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
          iconData: Icons.all_inclusive,
          onTap: () => state.input.setEntryFilters('All'),
        ),
        //
        MenuItem(
          label: 'Income',
          iconData: Icons.add,
          onTap: () => state.input.setEntryFilters('Income'),
        ),
        //
        MenuItem(
          label: 'Expenses',
          iconData: Icons.remove,
          onTap: () => state.input.setEntryFilters('Expenses'),
        ),
        //
        MenuItem(
          label: 'Savings',
          iconData: Icons.savings,
          onTap: () => state.input.setEntryFilters('Savings'),
        ),
        //
      ],
      smallVerticalPadding: true,
      noStyling: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: AppText(text: state.input.filter)),
          spw(),
          AppSvg(svgPath: 'assets/icons/dropdown.svg'),
        ],
      ),
    );
  }
}
