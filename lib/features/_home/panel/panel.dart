import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/common/global.dart';
import '../../../_providers/common/views.dart';
import '../../../_widgets/buttons/buttons.dart';
import '../../../_widgets/others/images.dart';
import '../../../_widgets/others/others/scroll.dart';
import '../../../_widgets/others/sfcalendar.dart';
import '../../../_widgets/others/text.dart';
import '../../code/_w/code_files_list.dart';
import '../../labels/manager.dart';
import '../navbars/navbar_vertical.dart';

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
          color: styler.appColor(0.5),
          borderRadius: BorderRadius.circular(borderRadiusTiny),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            Padding(
              padding: padding(t: 8),
              child: AppButton(
                onPressed: () => views.setShowWebBoxOptions(!views.showPanelOptions),
                height: 30,
                noStyling: true,
                hoverColor: transparent,
                padding: EdgeInsets.zero,
                child: Row(
                  children: [
                    AppImage('sayari.png', size: 22),
                    if (showPanel) spw(),
                    if (showPanel) Expanded(child: AppText(size: large, text: 'Sayari', weight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
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
