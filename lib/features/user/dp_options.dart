import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_widgets/menu/menu_item.dart';
import '../../_widgets/others/theme_menu.dart';
import '../auth/_helpers/sign_out.dart';
import '../files/_helpers/download.dart';
import '../files/_helpers/dp.dart';
import '../files/viewer.dart';
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
    menuDivider(),
    MenuItem(onTap: () => showSettingsBottomSheet(), label: 'Account & Settings', leading: Icons.settings_rounded),
    MenuItem(onTap: () => showSavedSheet(), label: 'Saved', leading: Icons.bookmark),
    menuDivider(),
    MenuItem(onTap: () => showSavedSheet(), label: 'Theme', leading: Icons.dark_mode, menuItems: themeMenu(), menuWidth: 300),
    menuDivider(),
    MenuItem(onTap: () => signOutUser(), label: 'Sign Out', leading: Icons.exit_to_app),
    //
  ];
}

List<Widget> dpSettingsMenu() {
  return [
    //
    MenuItem(onTap: () async => await chooseUserDp(), label: 'Edit', leading: Icons.edit),
    MenuItem(
      onTap: () async => await showImageViewer(
        images: {'dp': 'dp.jpg'},
        onDownload: () async => await downloadFile(
          db: 'users',
          fileId: 'dp',
          fileName: 'dp.jpg',
          cloudFilePath: '${liveUser()}/' 'dp.jpg',
          downloadPath: 'dp.jpg',
        ),
      ),
      label: 'View',
      leading: Icons.image_outlined,
    ),
    //
  ];
}
