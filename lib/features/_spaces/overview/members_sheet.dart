import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_services/firebase/get_space_data.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/buttons/close.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/others/scroll.dart';
import '../../../_widgets/others/text.dart';
import '../../../_widgets/sheets/bottom_sheet.dart';
import '../_helpers/checks_space.dart';
import '../_helpers/common.dart';
import '../_helpers/member_helpers.dart';
import '_w/add_member.dart';
import '_w/member_chip.dart';

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
                smallLeftPadding: true,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppIcon(Icons.add_rounded),
                    tpw(),
                    AppText(text: 'Add Member'),
                  ],
                )),
          ),
        //
        mph(),
        //
        NoOverScroll(
          child: ValueListenableBuilder(
              valueListenable: Hive.box('${spaceId}_members').listenable(),
              builder: (context, box, widget) {
                Map memberData = box.toMap();
                if (memberData.isEmpty) {
                  getSpaceMemberData(spaceId);
                }

                return Wrap(
                  children: List.generate(memberData.length, (index) {
                    String userId = memberData.keys.toList()[index];
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
