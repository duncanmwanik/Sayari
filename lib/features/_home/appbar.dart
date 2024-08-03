import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/_common/navigation.dart';
import '../../_providers/common/selection.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/items/item_selection.dart';
import '../../_widgets/layout/layout_button.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/others/sync_indicator.dart';
import '../../_widgets/others/search.dart';
import '../../_widgets/others/theme.dart';
import '../files/user_dp.dart';
import 'tablename.dart';

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
                          child: AppIcon(Icons.sort_rounded),
                        ),
                        // selected table name
                        Flexible(child: TableName()),
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
                      //
                      Search(),
                      //
                      LayoutButton(),
                      //
                      QuickThemeChanger(),
                      //
                      UserDp(isTiny: true),
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
