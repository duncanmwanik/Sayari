import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/url_launcher.dart';
import '../../../_services/hive/store.dart';
import '../../../_theme/spacing.dart';
import '../../../_widgets/buttons/button.dart';
import '../../auth/_helpers/sign_out.dart';
import '../../user/_helpers/helpers.dart';
import 'title.dart';

class AccountSupport extends StatelessWidget {
  const AccountSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: storage('', space: liveUser()).listenable(),
        builder: (context, box, widget) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              SettingTitle('SUPPORT'),
              //
              sph(),
              //
              AppButton(
                onPressed: () => signOutUser(),
                leading: 'Sign Out',
                trailing: Icons.exit_to_app_rounded,
                faded: true,
              ),
              //
              tsph(),
              //
              AppButton(
                onLongPress: () => sendUserFeedbackViaEmail(),
                leading: 'Send Feedback',
                trailing: Icons.keyboard_arrow_right_rounded,
              ),
              //
            ],
          );
        });
  }
}
