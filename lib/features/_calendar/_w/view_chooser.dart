import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/common/views.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/abcs/menu/menu_item.dart';
import '../../../_widgets/others/svg.dart';
import '../../../_widgets/others/text.dart';

class ViewChooser extends StatelessWidget {
  const ViewChooser({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsProvider>(builder: (context, views, child) {
      return AppButton(
        tooltip: 'Change View',
        isDropDown: true,
        borderRadius: borderRadiusCrazy,
        menuWidth: 120,
        menuItems: [
          //
          MenuItem(
            label: 'Day',
            trailing: Icons.view_carousel_outlined,
            isSelected: views.calendarView == 0,
            onTap: () async => views.calendarView != 0 ? views.setSessionsView(0) : () {},
          ),
          MenuItem(
            label: 'Week',
            leadingSize: 14,
            trailing: Icons.view_week,
            isSelected: views.calendarView == 1,
            onTap: () async => views.calendarView != 1 ? views.setSessionsView(1) : () {},
          ),
          MenuItem(
            label: 'Month',
            trailing: Icons.calendar_month_rounded,
            isSelected: views.calendarView == 2,
            onTap: () async => views.calendarView != 2 ? views.setSessionsView(2) : () {},
          ),
          MenuItem(
            label: 'Year',
            trailing: Icons.view_compact_sharp,
            isSelected: views.calendarView == 3,
            onTap: () async => views.calendarView != 3 ? views.setSessionsView(3) : () {},
          ),
          //
        ],
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: AppText(text: sessionViews[views.calendarView])),
            spw(),
            AppSvg(svgPath: dropDownSvg),
          ],
        ),
      );
    });
  }
}
