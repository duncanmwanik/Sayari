import 'package:flutter/material.dart';

import '../../../_widgets/abcs/menu/menu_item.dart';
import '../../pomodoro/sheet.dart';
import '../../saved/saved_sheet.dart';
import '../../settings/settings_sheet.dart';

List<Widget> dpMenu() {
  return [
    //
    MenuItem(onTap: () => showSettingsBottomSheet(), label: 'Account & Settings', leading: Icons.settings_rounded),
    //
    MenuItem(onTap: () => showSavedSheet(), label: 'Saved', leading: Icons.bookmark),
    //
    MenuItem(onTap: () => showPomodoroSheet(), label: 'Pomodoro', leading: Icons.timer),
    //
  ];
}
