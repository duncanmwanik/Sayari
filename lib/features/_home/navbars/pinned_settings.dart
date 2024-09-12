import 'package:flutter/material.dart';

import '../../../__styling/breakpoints.dart';
import '../../../_variables/features.dart';
import '../../_spaces/_helpers/checks_space.dart';
import 'navbar_options.dart';

List<Widget> pinnedNavOptions() {
  return [
    //
    NavOptionToggle(type: feature.calendar.t, isDefault: true),
    NavOptionToggle(type: feature.items.t, isDefault: true),
    NavOptionToggle(type: feature.chat.t),
    if (isCodeSpace()) NavOptionToggle(type: feature.code.t),
    if (!isSmallPC()) NavOptionToggle(type: feature.explore.t),
    //
  ];
}
