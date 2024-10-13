import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/helpers.dart';
import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/global.dart';
import '../../../_providers/views.dart';
import '../../../_widgets/others/others/divider.dart';
import '../../../_widgets/others/others/scroll.dart';
import '../../../_widgets/others/sfcalendar.dart';
import '../../tags/manager.dart';
import '../navbars/navbar_vertical.dart';
import '../space.dart';

class Panel extends StatelessWidget {
  const Panel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ViewsProvider, GlobalProvider>(builder: (context, views, global, child) {
      bool showPanel = views.showPanelOptions && showPanelOptions();
      bool showCalendar = views.isCalendar() || views.isChat();
      bool showTagManager = views.isNotes() || views.isTasks();

      return Container(
        width: showPanel ? 253 : 53,
        height: double.maxFinite,
        margin: paddingM(),
        decoration: BoxDecoration(
            color: isDarkOnly() ? styler.appColor(0.3) : null,
            borderRadius: BorderRadius.circular(borderRadiusTiny),
            border: isDarkOnly() ? null : Border.all(color: styler.borderColor())),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            Padding(padding: paddingS('ltrb'), child: SpaceName(isMin: !showPanel)),
            if (!showPanel) tph(),
            Padding(padding: paddingS('lr'), child: AppDivider()),
            //
            msph(),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  VeticalNavigationBox(isCollapsed: !showPanel),
                  //
                  if (showPanel)
                    SizedBox(
                      width: 200,
                      child: NoScrollBars(
                        child: ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: BouncingScrollPhysics(),
                          children: [
                            //
                            if (showCalendar) Center(child: SfCalendar(isOverview: true)),
                            if (showTagManager) TagManager(),
                            //
                          ],
                        ),
                      ),
                    ),
                  //
                ],
              ),
            ),
            //
          ],
        ),
      );
    });
  }
}
