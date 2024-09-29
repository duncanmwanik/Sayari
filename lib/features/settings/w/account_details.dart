import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/others/list_tile.dart';
import '../../../_widgets/others/text.dart';
import '../../user/_helpers/helpers.dart';
import '../../user/dp.dart';
import '../../user/dp_menu.dart';
import '../edit_details.dart';
import 'title.dart';

class AccountDetails extends StatelessWidget {
  const AccountDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box(liveUser()).listenable(),
        builder: (context, box, widget) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              Center(child: UserDp(isTiny: false, menuItems: dpEditMenu())),
              //
              mph(),
              //
              SettingTitle('ACCOUNT'),
              //
              sph(),
              //
              AppListTile(
                leading: AppText(text: 'Name'),
                trailing: AppText(text: liveUserName()),
                onTap: () {},
              ),
              //
              tsph(),
              //
              AppListTile(
                leading: AppText(text: 'Email'),
                trailing: AppText(text: liveEmail()),
                onTap: () {},
              ),
              //
              tsph(),
              //
              AppListTile(
                leading: AppText(text: 'Edit Account Details'),
                trailing: AppIcon(Icons.keyboard_arrow_right_rounded, size: normal),
                onTap: () => showEditDetailsBottomSheet(context),
              ),
              //
            ],
          );
        });
  }
}
