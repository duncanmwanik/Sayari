import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_widgets/menu/menu_item.dart';
import '../auth/_helpers/sign_out.dart';
import '../saved/saved_sheet.dart';
import '../settings/settings_sheet.dart';
import '_helpers/set_user_data.dart';
import 'user_dp.dart';

List<Widget> dpMenu() {
  return [
    //
    UserDp(noViewer: true, onPressed: null, hoverColor: transparent, size: 50),
    sph(),
    MenuItem(label: liveUserName(), center: true, smallHeight: true),
    MenuItem(label: liveEmail(), center: true, smallHeight: true),
    PopupMenuDivider(height: smallHeight()),
    //
    MenuItem(onTap: () => showSettingsBottomSheet(), label: 'Account & Settings', leading: Icons.settings_rounded),
    //
    MenuItem(onTap: () => showSavedSheet(), label: 'Saved', leading: Icons.bookmark),
    //
    MenuItem(onTap: () => signOutUser(), label: 'Sign Out', leading: Icons.exit_to_app),
    //
  ];
}
