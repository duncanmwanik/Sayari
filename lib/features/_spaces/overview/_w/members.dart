import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../_services/firebase/get_space_data.dart';
import '../../../../_services/hive/local_storage_service.dart';
import '../../../../_services/hive/store.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/others/scroll.dart';
import '../../../../_widgets/others/text.dart';
import '../../_helpers/checks_space.dart';
import '../../_helpers/common.dart';
import '../../_helpers/member_helpers.dart';
import 'add_member.dart';
import 'member_chip.dart';

class SpaceMembers extends StatelessWidget {
  const SpaceMembers({super.key});

  @override
  Widget build(BuildContext context) {
    String spaceId = liveSpace();

    return ListView(
      shrinkWrap: true,
      physics: TopBlockedBouncingScrollPhysics(),
      children: [
        //
        tph(),
        // add members
        if (isAdmin())
          Align(
            alignment: Alignment.topRight,
            child: AppButton(
                onPressed: () async => await showAddAdminDialog(),
                showBorder: true,
                slp: true,
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
              valueListenable: storage('members', space: spaceId).listenable(),
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
    );
  }
}
