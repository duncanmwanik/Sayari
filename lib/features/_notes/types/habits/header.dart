import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_models/item.dart';
import '../../../../_providers/input.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_theme/variables.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/menu/menu_item.dart';
import '../../../../_widgets/others/svg.dart';
import '../../../../_widgets/others/text.dart';

class HabitHeader extends StatelessWidget {
  const HabitHeader({super.key, this.item});

  final Item? item;

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      Map data = item != null ? item!.data : input.item.data;
      String view = data['hv'] ?? '1';

      return AppButton(
        menuWidth: 150,
        menuItems: [
          // MenuItem(
          //   label: 'Week',
          //   leading: Icons.view_week_sharp,
          //   trailing: view == '0' ? Icons.done : null,
          //   onTap: () {
          //     input.update(action: 'add', key: 'hv', value: '0');
          //   },
          // ),
          MenuItem(
            label: 'Month',
            leading: Icons.calendar_month_rounded,
            trailing: view == '1' ? Icons.done : null,
            onTap: () {
              input.update('hv', '1');
            },
          ),
          MenuItem(
            label: 'Year',
            leading: Icons.view_module_rounded,
            trailing: view == '2' ? Icons.done : null,
            onTap: () {
              input.update('hv', '2');
            },
          ),
        ],
        isDropDown: true,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: AppText(text: view == '0' ? 'Week' : (view == '1' ? 'Month' : 'Year'))),
            spw(),
            AppSvg(dropDownSvg),
          ],
        ),
      );
    });
  }
}
