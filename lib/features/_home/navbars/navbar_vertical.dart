import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../_providers/views.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
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
                  navItem(timelineIcon, feature.timeline),
                  mph(),
                  navItem(notesIcon, feature.notes),
                  mph(),
                  navItem(tasksIcon, size: 20.5, feature.tasks),
                  mph(),
                  navItem(calendarIcon, feature.calendar),
                  mph(),
                  navItem(chatIcon, feature.chat),
                  mph(),
                  PanelToggle(),
                  Spacer(),
                  UserOptions(),
                  //
                ],
              ),
            );
          });
        });
  }
}
