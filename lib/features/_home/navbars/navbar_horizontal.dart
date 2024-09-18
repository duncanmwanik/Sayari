import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/common/theme.dart';
import '../../../_providers/common/views.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_variables/features.dart';
import '../../_spaces/_helpers/checks_space.dart';
import '../../explore/explore_sheet.dart';
import '../_helpers/nav.dart';
import 'nav_item.dart';
import 'nav_menu.dart';

class HorizontalNavigationBox extends StatelessWidget {
  const HorizontalNavigationBox({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: settingBox.listenable(),
        builder: (context, box, widget) {
          return Consumer2<ViewsProvider, ThemeProvider>(builder: (context, views, theme, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                if (!isSmallPC())
                  Container(
                    height: 60,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(color: styler.navColor()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //
                        navItem(notesSelectedIcon, feature.items.t, views.view == feature.items.t),
                        //
                        navItem(sessionsSelectedIcon, feature.calendar.t, views.view == feature.calendar.t),
                        //
                        if (showNavOption(feature.chat.t)) navItem(chatSelectedIcon, feature.chat.t, views.view == feature.chat.t),
                        //
                        if (isCodeSpace() && showNavOption(feature.code.t))
                          navItem(codeSelectedIcon, feature.code.t, views.view == feature.code.t),
                        //
                        if (showNavOption(feature.explore.t))
                          navItem(exploreSelectedIcon, feature.explore.t, views.view == feature.explore.t,
                              onPressed: () => showExploreSheet()),
                        //
                        NavMenu(),
                        //
                      ],
                    ),
                  ),
              ],
            );
          });
        });
  }
}
