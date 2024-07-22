import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/common/theme.dart';
import '../../../_providers/common/views.dart';
import '../../../_variables/features.dart';
import 'nav_item.dart';
import 'nav_settings.dart';

class HorizontalNavigationBox extends StatelessWidget {
  const HorizontalNavigationBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ViewsProvider, ThemeProvider>(builder: (context, views, theme, child) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          if (!showVertNav())
            Container(
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(color: styler.navColor()),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //
                  navItem(sessionsSelectedIcon, feature.sessions.t, views.view == feature.sessions.t),
                  navItem(notesSelectedIcon, feature.notes.t, views.view == feature.notes.t),
                  navItem(chatSelectedIcon, feature.chat.t, views.view == feature.chat.t),
                  navItem(exploreSelectedIcon, feature.explore.t, views.view == feature.explore.t),
                  NavSettings(),
                  //
                ],
              ),
            ),
        ],
      );
    });
  }
}
