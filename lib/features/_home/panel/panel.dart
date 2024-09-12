import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/common/global.dart';
import '../../../_providers/common/views.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/images.dart';
import '../../../_widgets/others/others/scroll.dart';
import '../../../_widgets/others/sfcalendar.dart';
import '../../../_widgets/others/text.dart';
import '../../code/_w/code_files_list.dart';
import '../../labels/manager.dart';
import '../navbars/navbar_vertical.dart';
import 'creator.dart';

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
        margin: partitionPadding(),
        decoration: BoxDecoration(
          color: styler.appColor(0.5),
          borderRadius: BorderRadius.circular(borderRadiusSmall),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Column(
                crossAxisAlignment: showPanel ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                children: [
                  // branding
                  Padding(
                    padding: EdgeInsets.only(left: showPanel ? 14 : 0),
                    child: AppButton(
                      onPressed: () => views.setShowWebBoxOptions(!views.showPanelOptions),
                      height: 30,
                      noStyling: true,
                      dryWidth: true,
                      hoverColor: transparent,
                      padding: EdgeInsets.zero,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AppImage(imagePath: 'assets/images/sayari.png', size: 22),
                          if (showPanel) spw(),
                          if (showPanel) AppText(size: large, text: 'Sayari', fontWeight: FontWeight.w800),
                        ],
                      ),
                    ),
                  ),
                  //
                  mph(),
                  //
                  Center(child: WebCreator(isCollapsed: !showPanel)),
                  //
                  sph(),
                ],
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
                            if (showCalendar) Center(child: SfCalendar(isWebCalendar: true)),
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
