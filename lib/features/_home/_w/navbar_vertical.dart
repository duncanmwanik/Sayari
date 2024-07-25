import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/common/views.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../_helpers/nav.dart';
import 'nav_item.dart';
import 'nav_settings.dart';
import 'toggle_left_box.dart';

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
                  sph(),
                  navItem(sessionsSelectedIcon, feature.sessions.t, views.view == feature.sessions.t),
                  msph(),
                  navItem(notesSelectedIcon, feature.notes.t, views.view == feature.notes.t),
                  msph(),
                  if (showNavOption(feature.chat.t))
                    navItem(chatSelectedIcon, feature.chat.t, views.view == feature.chat.t),
                  if (showNavOption(feature.chat.t)) msph(),
                  if (showNavOption(feature.explore.t))
                    navItem(exploreSelectedIcon, feature.explore.t, views.view == feature.explore.t),
                  if (showNavOption(feature.explore.t)) msph(),
                  if (showNavOption(feature.code.t))
                    navItem(codeSelectedIcon, feature.code.t, views.view == feature.code.t),
                  if (showNavOption(feature.code.t)) msph(),
                  NavSettings(),
                  //
                  Spacer(),
                  //
                  if (showWebBoxOptions()) WebLeftBoxToggle(),
                  if (showWebBoxOptions()) sph(),
                  //
                  AppButton(
                    onPressed: () {},
                    noStyling: true,
                    isSquare: true,
                    tooltip: 'Speak',
                    child: AppIcon(Icons.blur_on, faded: true, size: 18),
                  ),
                  //
                  mph(),
                  //
                ],
              ),
            );
          });
        });
  }
}
