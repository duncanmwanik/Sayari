import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_widgets/buttons/close_button.dart';
import '../../_widgets/others/others/about_app.dart';
import '../../_widgets/others/others/scroll.dart';
import '../../_widgets/others/text.dart';
import '../../_widgets/sheets/bottom_sheet.dart';
import '_w/account_details.dart';
import '_w/account_support.dart';
import '_w/theme_settings.dart';

Future<void> showSettingsBottomSheet() async {
  await showAppBottomSheet(
    isFull: true,
    //
    header: Row(
      children: [
        AppCloseButton(isX: false),
        spw(),
        Expanded(child: AppText(text: 'Settings', size: normal)),
      ],
    ),
    //
    content: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: webMaxWidth),
      child: NoScrollBars(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //
              sph(),
              //
              AccountDetails(),
              //
              mph(),
              //
              ThemeSettings(),
              //
              mph(),
              //
              AccountSupport(),
              //
              AboutApp(),
              //
            ],
          ),
        ),
      ),
    ),
  );
}
