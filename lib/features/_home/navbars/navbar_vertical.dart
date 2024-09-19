import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/views.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_variables/features.dart';
import '../../_spaces/_helpers/checks_space.dart';
import '../_helpers/nav.dart';
import '../panel/user_options.dart';
import 'nav_item.dart';

class VeticalNavigationBox extends StatelessWidget {
  const VeticalNavigationBox({super.key, required this.isCollapsed});

  final bool isCollapsed;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: settingBox.listenable(),
        builder: (context, box, widget) {
          //
          return Consumer<ViewsProvider>(builder: (context, views, child) {
            return Container(
              width: 50,
              decoration: BoxDecoration(
                border: isCollapsed ? null : Border(right: BorderSide(color: styler.borderColor(), width: 0.5)),
              ),
              child: Column(
                children: [
                  //
                  navItem(notesSelectedIcon, feature.items.t, views.view == feature.items.t),
                  msph(),
                  navItem(sessionsSelectedIcon, feature.calendar.t, views.view == feature.calendar.t),
                  msph(),
                  if (showNavOption(feature.chat.t)) navItem(chatSelectedIcon, feature.chat.t, views.view == feature.chat.t),
                  if (showNavOption(feature.chat.t)) msph(),
                  if (isCodeSpace() && showNavOption(feature.code.t))
                    navItem(codeSelectedIcon, feature.code.t, views.view == feature.code.t),
                  if (isCodeSpace() && showNavOption(feature.code.t)) msph(),
                  //
                  Spacer(),
                  //
                  UserOptions(),
                  //
                ],
              ),
            );
          });
        });
  }
}
