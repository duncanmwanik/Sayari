import 'package:flutter/material.dart';

import '../../../__styling/breakpoints.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/menu/menu_item.dart';
import 'navbar_options.dart';

List<Widget> pinnedNavOptions() {
  return [
    // workspace
    MenuItem(label: 'Workspace', faded: true),
    NavOptionToggle(type: feature.chat),
    //
    menuDivider(),
    // user
    MenuItem(label: 'User', faded: true),
    NavOptionToggle(type: feature.explore),
    if (showPanelOptions()) NavOptionToggle(type: feature.saved),
    if (showPanelOptions()) NavOptionToggle(type: feature.pomodoro),
    //
  ];
}
