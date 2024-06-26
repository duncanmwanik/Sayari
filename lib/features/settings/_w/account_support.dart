import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/url_launcher.dart';
import '../../../_helpers/user/set_user_data.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/others/list_tile.dart';
import '../../../_widgets/others/text.dart';
import '../../auth/_helpers/sign_out.dart';
import 'title.dart';

class AccountSupport extends StatelessWidget {
  const AccountSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box(liveUser()).listenable(),
        builder: (context, box, widget) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              SettingTitle('SUPPORT'),
              //
              sph(),
              //
              AppListTile(
                leading: AppText(text: 'Sign Out'),
                trailing: AppIcon(Icons.exit_to_app_rounded, faded: true, size: normal),
                onTap: () => signOutUser(),
              ),
              //
              tsph(),
              //
              AppListTile(
                leading: AppText(text: 'Send Feedback'),
                trailing: AppIcon(Icons.keyboard_arrow_right_rounded, size: normal),
                onTap: () => sendUserFeedbackViaEmail(),
              ),
              //
            ],
          );
        });
  }
}
