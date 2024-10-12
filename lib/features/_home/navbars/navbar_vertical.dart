import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/views.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_variables/features.dart';
import '../panel/toggle.dart';
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
                border: isCollapsed ? null : Border(right: BorderSide(color: styler.borderColor())),
              ),
              child: Column(
                children: [
                  //
                  navItem(notesIcon, feature.notes, views.view == feature.notes),
                  mph(),
                  navItem(tasksIcon, size: 20.5, feature.tasks, views.view == feature.tasks),
                  mph(),
                  navItem(sessionsIcon, size: 17, feature.calendar, views.view == feature.calendar),
                  mph(),
                  //
                  PanelToggle(),
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
