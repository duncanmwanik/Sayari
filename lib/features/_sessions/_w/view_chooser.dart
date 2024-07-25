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
    return Consumer<ViewsProvider>(builder: (context, viewsProvider, child) {
      return AppButton(
        tooltip: 'Change View',
        borderRadius: borderRadiusCrazy,
        menuWidth: 120,
        menuItems: [
          //
          MenuItem(
            label: 'Day',
            trailing: Icons.view_carousel_outlined,
            isSelected: viewsProvider.sessionsView == 0,
            onTap: () async => viewsProvider.sessionsView != 0 ? viewsProvider.setSessionsView(0) : () {},
          ),
          MenuItem(
            label: 'Week',
            leadingSize: 14,
            trailing: Icons.view_week,
            isSelected: viewsProvider.sessionsView == 1,
            onTap: () async => viewsProvider.sessionsView != 1 ? viewsProvider.setSessionsView(1) : () {},
          ),
          MenuItem(
            label: 'Month',
            trailing: Icons.calendar_month_rounded,
            isSelected: viewsProvider.sessionsView == 2,
            onTap: () async => viewsProvider.sessionsView != 2 ? viewsProvider.setSessionsView(2) : () {},
          ),
          MenuItem(
            label: 'Year',
            trailing: Icons.view_compact_sharp,
            isSelected: viewsProvider.sessionsView == 3,
            onTap: () async => viewsProvider.sessionsView != 3 ? viewsProvider.setSessionsView(3) : () {},
          ),
          //
        ],
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: AppText(text: sessionViews[viewsProvider.sessionsView])),
            spw(),
            AppSvg(svgPath: 'assets/icons/dropdown.svg'),
          ],
        ),
      );
    });
  }
}
