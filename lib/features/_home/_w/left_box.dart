import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/common/global_provider.dart';
import '../../../_providers/common/views.dart';
import '../../../_widgets/others/images.dart';
import '../../../_widgets/others/others/scroll.dart';
import '../../../_widgets/others/sfcalendar.dart';
import '../../../_widgets/others/text.dart';
import '../../labels/label_manager.dart';
import 'creator.dart';
import 'navbar_vertical.dart';

class WebLeftBox extends StatelessWidget {
  const WebLeftBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ViewsProvider, GlobalProvider>(builder: (context, views, global, child) {
      bool showBoxOptions = views.showWebBoxOptions && showWebBoxOptions();
      bool showCalendar = views.isSessions() || views.isChat();
      bool showLabelManager = views.isNotes();

      return Container(
        width: showBoxOptions ? 251 : 51,
        height: double.maxFinite,
        decoration: BoxDecoration(
          border: Border(right: BorderSide(color: styler.borderColor(), width: 0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                crossAxisAlignment: showBoxOptions ? CrossAxisAlignment.start : CrossAxisAlignment.center,
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
                        if (showBoxOptions) spw(),
                        if (showBoxOptions) AppText(size: large, text: 'Sayari', fontWeight: FontWeight.w700),
                        //
                      ],
                    ),
                  ),
                  //
                  mph(),
                  sph(),
                  //
                  Padding(
                    padding: EdgeInsets.only(left: showBoxOptions ? 14 : 0, right: showBoxOptions ? 5 : 0),
                    child: WebCreator(isCollapsed: !showBoxOptions),
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
                  VeticalNavigationBox(isCollapsed: !showBoxOptions),
                  //
                  if (showBoxOptions)
                    SizedBox(
                      width: 200,
                      child: ScrollConfiguration(
                        behavior: AppScrollBehavior().copyWith(scrollbars: false),
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
