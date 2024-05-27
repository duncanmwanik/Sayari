import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/common/views.dart';
import '../../../_variables/strings.dart';
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
        borderRadius: borderRadiusSmall,
        menuWidth: 150,
        menuItems: [
          //
          MenuItem(
            label: 'Day',
            iconData: Icons.view_carousel_outlined,
            trailing: viewsProvider.sessionsView == 0 ? Icons.done_rounded : null,
            onTap: () async => viewsProvider.sessionsView != 0 ? viewsProvider.setSessionsView(0) : () {},
          ),
          MenuItem(
            label: 'Week',
            leadingSize: 14,
            iconData: Icons.view_week,
            trailing: viewsProvider.sessionsView == 1 ? Icons.done_rounded : null,
            onTap: () async => viewsProvider.sessionsView != 1 ? viewsProvider.setSessionsView(1) : () {},
          ),
          MenuItem(
            label: 'Month',
            iconData: Icons.calendar_month_rounded,
            trailing: viewsProvider.sessionsView == 2 ? Icons.done_rounded : null,
            onTap: () async => viewsProvider.sessionsView != 2 ? viewsProvider.setSessionsView(2) : () {},
          ),
          MenuItem(
            label: 'Year',
            iconData: Icons.view_compact_sharp,
            trailing: viewsProvider.sessionsView == 3 ? Icons.done_rounded : null,
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
