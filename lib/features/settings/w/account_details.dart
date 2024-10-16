import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../_services/hive/store.dart';
import '../../../_theme/spacing.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/text.dart';
import '../../user/_helpers/helpers.dart';
import '../../user/dp.dart';
import '../../user/dp_menu.dart';
import 'title.dart';

class AccountDetails extends StatelessWidget {
  const AccountDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: storage('', space: liveUser()).listenable(),
        builder: (context, box, widget) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              Center(child: UserDp(isTiny: false, menuItems: dpEditMenu())),
              mph(),
              SettingTitle('ACCOUNT'),
              AppButton(
                onPressed: () {},
                leading: 'Name',
                trailing: AppText(text: liveUserName()),
              ),
              tsph(),
              AppButton(
                onPressed: () {},
                leading: 'Email',
                trailing: liveEmail(),
              ),
              //
            ],
          );
        });
  }
}
