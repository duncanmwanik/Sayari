import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/clipboard.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_helpers/date_time/date_info.dart';
import '../../../_widgets/buttons/close.dart';
import '../../../_widgets/others/empty_box.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/others/divider.dart';
import '../../../_widgets/others/others/list_tile.dart';
import '../../../_widgets/others/others/scroll.dart';
import '../../../_widgets/others/text.dart';
import '../../../_widgets/sheets/bottom_sheet.dart';
import '../_helpers/checks_space.dart';
import '../_helpers/common.dart';
import '../_helpers/helpers.dart';
import '../published/button.dart';
import '_w/space_about.dart';
import '_w/space_admin_tile.dart';
import '_w/space_name.dart';
import '_w/space_notfications_tile.dart';
import '_w/space_owner_tile.dart';

Future<void> showSpaceOverviewBottomSheet() async {
  String spaceId = liveSpace();

  await showAppBottomSheet(
    isFull: true,
    //
    header: Row(
      children: [
        AppCloseButton(),
        spw(),
        Expanded(child: SpaceName()),
      ],
    ),
    //
    content: ValueListenableBuilder(
        valueListenable: Hive.box('${liveSpace()}_info').listenable(),
        builder: (context, box, widget) {
          Map spaceData = box.toMap();
          String description = spaceData['n'] ?? '';

          return ConstrainedBox(
            constraints: BoxConstraints(maxWidth: webMaxWidth),
            child: spaceId != 'none'
                ? NoScrollBars(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //
                          if (description.isNotEmpty) SpaceDescription(spaceDescription: description),
                          //
                          kIsWeb ? sph() : tsph(),
                          //
                          AppListTile(
                            leading: 'Starts',
                            trailing: getDayInfoFullNames(spaceData['j'] ?? '...'),
                          ),
                          //
                          kIsWeb ? sph() : tsph(),
                          //
                          AppListTile(
                            leading: 'Ends',
                            trailing: getDayInfoFullNames(spaceData['k'] ?? '...'),
                          ),
                          //
                          kIsWeb ? sph() : tsph(),
                          //
                          AppListTile(
                            leading: 'Space Id',
                            trailing: spaceId,
                            onTap: () async => await copyToClipboard(spaceId),
                          ),
                          //
                          kIsWeb ? sph() : tsph(),
                          //
                          SpaceOwnerTile(ownerId: spaceData['o'] ?? '-'),
                          //
                          kIsWeb ? sph() : tsph(),
                          //
                          SpaceNotificationsTile(spaceName: spaceData['t'] ?? '-'),
                          //
                          kIsWeb ? sph() : tsph(),
                          //
                          SpaceAdminTile(),
                          //
                          kIsWeb ? sph() : tsph(),
                          //
                          if (isAdmin())
                            AppListTile(
                              leading: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AppIcon(Icons.edit, size: medium),
                                  spw(),
                                  Flexible(child: AppText(text: 'Edit Workspace')),
                                ],
                              ),
                              trailing: AppIcon(Icons.keyboard_arrow_right_rounded, size: 18),
                              onTap: () => prepareSpaceForEdit(spaceData),
                            ),
                          //
                          if (isAdmin()) mph(),
                          if (isAdmin()) AppText(text: 'Other Actions', size: small, faded: true),
                          if (isAdmin()) AppDivider(height: mediumHeight()),
                          //
                          if (isAdmin()) PublishButton(spaceData: spaceData),
                          //
                          lpph(),
                          //
                        ],
                      ),
                    ),
                  )
                : EmptyBox(
                    onPressed: () {
                      popWhatsOnTop();
                      openDrawer();
                    },
                    label: 'Tap to select a space',
                  ),
          );
        }),
  );
}
