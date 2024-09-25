import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/theme.dart';
import '../../../_providers/views.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_variables/features.dart';
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
                        navItem(notesSelectedIcon, feature.notes, views.view == feature.notes),
                        navItem(Icons.check_box_rounded, size: 20.5, feature.tasks, views.view == feature.tasks),
                        navItem(sessionsSelectedIcon, size: 17, feature.calendar, views.view == feature.calendar),
                        //
                        if (showNavOption(feature.chat)) navItem(chatSelectedIcon, feature.chat, views.view == feature.chat),
                        //
                        //
                        if (showNavOption(feature.explore))
                          navItem(exploreSelectedIcon, feature.explore, views.view == feature.explore, onPressed: () => showExploreSheet()),
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
