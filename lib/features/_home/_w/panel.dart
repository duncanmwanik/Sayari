import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/common/global_provider.dart';
import '../../../_providers/common/views.dart';
import '../../../_variables/navigation.dart';
import '../../../_widgets/others/images.dart';
import '../../../_widgets/others/sfcalendar.dart';
import '../../../_widgets/others/text.dart';
import '../../code/_w/code_files_list.dart';
import '../../labels/label_manager.dart';
import '../creator.dart';
import 'navbar_vertical.dart';

class Panel extends StatelessWidget {
  const Panel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ViewsProvider, GlobalProvider>(builder: (context, views, global, child) {
      bool showPanel = views.showWebBoxOptions && showWebBoxOptions();
      bool showCalendar = views.isSessions() || views.isChat();
      bool showLabelManager = views.isNotes();

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
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                crossAxisAlignment: showPanel ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                children: [
                  // branding
                  Container(
                    height: 30,
                    padding: const EdgeInsets.only(left: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //
                        AppImage(imagePath: 'assets/images/sayari.png', size: 22),
                        if (showPanel) spw(),
                        if (showPanel) AppText(size: large, text: 'Sayari', fontWeight: FontWeight.w800),
                        //
                      ],
                    ),
                  ),
                  //
                  mph(),
                  //
                  Padding(
                    padding: EdgeInsets.only(left: showPanel ? 5 : 0, right: showPanel ? 5 : 0),
                    child: WebCreator(isCollapsed: !showPanel),
                  ),
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
                      child: ScrollConfiguration(
                        behavior: scrollNoBars,
                        child: ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: BouncingScrollPhysics(),
                          children: [
                            //
                            if (showCalendar) Center(child: SfCalendar(isWebCalendar: true)),
                            //
                            if (showLabelManager) LabelManager(),
                            //
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
