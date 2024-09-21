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
import '../../code/_w/code_files_list.dart';
import '../../labels/manager.dart';
import '../navbars/navbar_vertical.dart';
import 'space.dart';

class Panel extends StatelessWidget {
  const Panel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ViewsProvider, GlobalProvider>(builder: (context, views, global, child) {
      bool showPanel = views.showPanelOptions && showPanelOptions();
      bool showCalendar = views.isCalendar() || views.isChat();
      bool showLabelManager = views.isItems();

      return Container(
        width: showPanel ? 251 : 51,
        height: double.maxFinite,
        margin: paddingM(),
        decoration: BoxDecoration(
          color: styler.appColor(isDark() ? 0.5 : 0.7),
          borderRadius: BorderRadius.circular(borderRadiusTiny),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            Padding(padding: paddingS('ltrb'), child: SpaceName(isMin: !showPanel)),
            AppDivider(height: 0),
            sph(),
            //
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
                            if (showLabelManager) LabelManager(),
                            if (views.isCode()) CodeFilesList(),
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
