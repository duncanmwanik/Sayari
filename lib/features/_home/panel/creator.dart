import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_providers/common/views.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../_calendar/_helpers/helpers.dart';
import '../../_notes/_helpers/helpers.dart';
import '../../_spaces/_helpers/checks_space.dart';
import '../../code/_w/dialog_create_code.dart';

class WebCreator extends StatelessWidget {
  const WebCreator({super.key, this.isCollapsed = false});

  final bool isCollapsed;

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsProvider>(builder: (context, views, child) {
      bool isCalendarView = views.isCalendar();
      bool isItemsView = views.isItems();

      return Padding(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: AppButton(
          isRound: isCollapsed,
          borderRadius: borderRadiusLarge,
          padding: EdgeInsets.zero,
          noStyling: true,
          onPressed: isASpaceSelected()
              ? () {
                  if (isCalendarView) prepareSessionCreation();
                  if (isItemsView) prepareNoteForCreation();
                  if (views.isCode()) showCreateCodeFileDialog();
                }
              : () => openDrawer(),
          child: Container(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: isCollapsed ? 5 : 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadiusLarge),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                transform: GradientRotation(1.5),
                colors: [
                  styler.accentColor().withOpacity(0.3),
                  styler.accentColor().withOpacity(0.15),
                  styler.accentColor().withOpacity(0.05),
                ],
              ),
            ),
            child: isASpaceSelected()
                ? Row(
                    mainAxisAlignment: isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
                    mainAxisSize: isCollapsed ? MainAxisSize.min : MainAxisSize.max,
                    children: [
                      //
                      AppIcon(Icons.add, size: 25),
                      if (!isCollapsed) spw(),
                      if (!isCollapsed && isItemsView) AppText(text: features[views.itemsView]!.message, fontWeight: FontWeight.w700),
                      if (!isCollapsed && !isItemsView) AppText(text: features[views.view]!.message, fontWeight: FontWeight.w700),
                      //
                    ],
                  )
                : Center(child: AppText(text: 'Select a space', overflow: TextOverflow.ellipsis)),
          ),
        ),
      );
    });
  }
}
