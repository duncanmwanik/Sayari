import 'package:flutter/material.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/spacing.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../../_spaces/_helpers/checks_space.dart';
import 'navbar_options.dart';

List<Widget> pinnedNavOptions() {
  return [
    // workspace
    MenuItem(label: 'Workspace', faded: true),
    NavOptionToggle(type: feature.calendar.t, isDefault: true),
    NavOptionToggle(type: feature.items.t, isDefault: true),
    NavOptionToggle(type: feature.chat.t),
    //
    if (isCodeSpace()) NavOptionToggle(type: feature.code.t),
    //
    PopupMenuDivider(height: smallHeight()),
    // user
    MenuItem(label: 'User', faded: true),
    NavOptionToggle(type: feature.explore.t),
    if (showPanelOptions()) NavOptionToggle(type: feature.saved.t),
    if (showPanelOptions()) NavOptionToggle(type: feature.pomodoro.t),
    //
  ];
}
