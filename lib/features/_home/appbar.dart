import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/_common/navigation.dart';
import '../../_providers/common/selection.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/layout/layout_button.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/others/sync_indicator.dart';
import '../../_widgets/others/theme.dart';
import '../_notes/items/item_selection.dart';
import '../files/user_dp.dart';
import '../pomodoro/_w/pomo_indicator.dart';
import '../search/search_btn.dart';
import 'appbar/dp_options.dart';
import 'appbar/space_name.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectionProvider>(builder: (context, selection, child) {
      bool isItemSelection = selection.isSelection;

      return Container(
        margin: partitionPadding(top: true, bottom: true, right: true, left: !isSmallPC()),
        padding: itemPaddingSmall(),
        decoration: BoxDecoration(
          color: styler.appColor(0.5),
          borderRadius: BorderRadius.circular(borderRadiusSmall),
        ),
        child: isItemSelection
            ? SelectedItemOptions()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //
                  Flexible(
                    child: Row(
                      children: [
                        // drawer button
                        AppButton(
                          onPressed: () => openDrawer(),
                          tooltip: 'All Workspaces',
                          isSquare: true,
                          noStyling: true,
                          borderRadius: borderRadiusTinySmall,
                          child: AppIcon(Icons.sort_rounded),
                        ),
                        // selected space name
                        Flexible(child: SpaceName()),
                        //
                      ],
                    ),
                  ),
                  //
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //
                      CloudSyncIndicator(),
                      PomodoroIndicator(),
                      Search(),
                      LayoutButton(),
                      QuickThemeChanger(),
                      pw(6),
                      UserDp(isTiny: true, menuItems: dpMenu(), tooltip: 'Account Options'),
                      //
                    ],
                  ),
                  //
                ],
              ),
      );
    });
  }
}
