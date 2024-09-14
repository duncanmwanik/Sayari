import 'package:flutter/material.dart';

import '../../_widgets/menu/menu_item.dart';
import '../auth/_helpers/sign_out.dart';
import '../saved/saved_sheet.dart';
import '../settings/settings_sheet.dart';

List<Widget> dpMenu() {
  return [
    //
    MenuItem(onTap: () => showSettingsBottomSheet(), label: 'Account & Settings', leading: Icons.settings_rounded),
    //
    MenuItem(onTap: () => showSavedSheet(), label: 'Saved', leading: Icons.bookmark),
    //
    MenuItem(onTap: () => signOutUser(), label: 'Sign Out', leading: Icons.exit_to_app),
    //
  ];
}
