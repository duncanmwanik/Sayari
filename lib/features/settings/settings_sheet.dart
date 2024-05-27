import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/abcs/dialogs_sheets/bottom_sheet.dart';
import '../../_widgets/others/others/about_app.dart';
import '../../_widgets/others/text.dart';
import '_w/account_details.dart';
import '_w/account_support.dart';
import '_w/theme_settings.dart';

Future<void> showSettingsBottomSheet() async {
  await showAppBottomSheet(
    //
    header: Row(
      children: [
        AppCloseButton(),
        spw(),
        Expanded(child: AppText(text: 'Settings', size: normal)),
      ],
    ),
    //
    content: SingleChildScrollView(
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
  );
}
