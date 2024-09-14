import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_services/firebase/get_space_data.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/buttons/buttons.dart';
import '../../../_widgets/buttons/close_button.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/others/scroll.dart';
import '../../../_widgets/others/text.dart';
import '../../../_widgets/sheets/bottom_sheet.dart';
import '../_helpers/admin_helpers.dart';
import '../_helpers/checks_space.dart';
import '../_helpers/common.dart';
import '_w/admin_chip.dart';
import '_w/dialog_add_admin.dart';

Future<void> showAdminsBottomSheet({required String title}) async {
  String spaceId = liveSpace();

  await showAppBottomSheet(
    //
    header: Row(
      children: [
        AppCloseButton(isX: false),
        spw(),
        Flexible(child: AppText(size: normal, text: title)),
      ],
    ),
    //
    content: ListView(
      shrinkWrap: true,
      physics: TopBlockedBouncingScrollPhysics(),
      children: [
        //
        mph(),
        //
        if (isAdmin())
          Align(
            alignment: Alignment.topRight,
            child: AppButton(
                onPressed: () async => await showAddAdminDialog(),
                borderRadius: borderRadiusLarge,
                smallLeftPadding: true,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppIcon(Icons.add_rounded),
                    tpw(),
                    AppText(text: 'Add Admin'),
                  ],
                )),
          ),
        //
        mph(),
        //
        NoOverScroll(
          child: ValueListenableBuilder(
              valueListenable: Hive.box('${spaceId}_admins').listenable(),
              builder: (context, box, widget) {
                Map adminData = box.toMap();
                if (adminData.isEmpty) {
                  getSpaceAdminData(spaceId);
                }

                return Wrap(
                  children: List.generate(adminData.length, (index) {
                    String userId = adminData.keys.toList()[index];
                    if (userEmailsBox.get(userId, defaultValue: null) == null) {
                      getAdminEmail(userId);
                    }

                    return AdminChip(
                      spaceId: spaceId,
                      userEmail: userEmailsBox.get(userId, defaultValue: '---'),
                      userId: userId,
                    );
                  }),
                );
              }),
        ),
        //
      ],
    ),
    //
  );
}
