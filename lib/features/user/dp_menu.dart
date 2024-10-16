import 'package:flutter/material.dart';

import '../../_helpers/navigation.dart';
import '../../_theme/spacing.dart';
import '../../_theme/theme_menu.dart';
import '../../_theme/variables.dart';
import '../../_widgets/menu/menu_item.dart';
import '../auth/_helpers/sign_out.dart';
import '../files/_helpers/download.dart';
import '../files/_helpers/helper.dart';
import '../files/viewer.dart';
import '../pomodoro/sheet.dart';
import '../saved/saved_sheet.dart';
import '../settings/settings_sheet.dart';
import '_helpers/dp.dart';
import '_helpers/helpers.dart';
import 'dp.dart';

List<Widget> dpMenu() {
  return [
    //
    MenuItem(label: '', popTrailing: true, smallHeight: true),
    Center(
        child: UserDp(
            onPressed: () {
              popWhatsOnTop();
              showSettingsBottomSheet();
            },
            hoverColor: transparent,
            size: 50)),
    sph(),
    MenuItem(label: liveUserName(), labelSize: tinySmall, faded: true, smallHeight: true),
    MenuItem(label: liveEmail(), labelSize: tinySmall, faded: true, smallHeight: true),
    tph(),
    menuDivider(color: styler.accentColor()),
    MenuItem(onTap: () => showSettingsBottomSheet(), label: 'Account & Settings', leading: Icons.settings_rounded),
    // MenuItem(label: 'Saved', leading: Icons.bookmark, onTap: () => showSavedSheet()),
    // MenuItem(label: 'Explore', leading: Icons.explore, onTap: () => showExploreSheet()),
    MenuItem(label: 'Pomodoro', leading: Icons.timer, onTap: () => showPomodoroSheet()),
    menuDivider(),
    MenuItem(onTap: () => showSavedSheet(), label: 'Theme', leading: Icons.dark_mode, menuItems: themeMenu(), menuWidth: 300),
    menuDivider(),
    MenuItem(onTap: () => signOutUser(), label: 'Sign Out', leading: Icons.exit_to_app),
    //
  ];
}

List<Widget> dpEditMenu() {
  return [
    //
    MenuItem(onTap: () async => await chooseUserDp(), label: 'Edit', leading: Icons.edit),
    if (hasUserDp())
      MenuItem(
        onTap: () async => await showImageViewer(
          images: {userDpId(): userDp()},
          onDownload: () async => await downloadFile(
            db: 'users',
            fileId: userDpId(),
            fileName: userDp(),
            cloudFilePath: '${liveUser()}/${userDp()}',
            downloadPath: 'dp.${getfileExtension(userDp())}',
          ),
        ),
        label: 'View',
        leading: Icons.image_outlined,
      ),
    if (hasUserDp()) MenuItem(onTap: () => removeUserDp(), label: 'Remove', leading: Icons.close),
    //
  ];
}
