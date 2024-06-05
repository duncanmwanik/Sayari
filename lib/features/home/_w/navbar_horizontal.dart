import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/variables.dart';
import '../../../_providers/common/theme.dart';
import '../../../_providers/common/views.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/others/others/divider.dart';
import '../../_tables/_helpers/checks_table.dart';
import '../../chat/input_bar.dart';
import '../_w/nav_item.dart';

class HorizontalNavigationBox extends StatelessWidget {
  const HorizontalNavigationBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ViewsProvider, ThemeProvider>(builder: (context, views, theme, child) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          if (isATableSelected() && views.isChat()) MessageInputBar(),
          if (isATableSelected() && views.isChat()) AppDivider(height: 0),
          //
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: styler.navColor(),
              // boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: styler.isDark ? 0 : 1, blurRadius: 1)],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //
                navItem(views.view == feature.sessions.t ? Icons.calendar_month : sessionsUnselectedIcon,
                    feature.sessions.t, views.view == feature.sessions.t),
                //
                navItem(views.view == feature.notes.t ? notesSelectedIcon : notesUnselectedIcon, feature.notes.t,
                    views.view == feature.notes.t),
                //
                navItem(views.view == feature.chat.t ? chatSelectedIcon : chatUnselectedIcon, feature.chat.t,
                    views.view == feature.chat.t),
                //
                navItem(views.view == feature.explore.t ? moreIcon : moreIcon, feature.explore.t,
                    views.view == feature.explore.t),
                //
              ],
            ),
          ),
        ],
      );
    });
  }
}
