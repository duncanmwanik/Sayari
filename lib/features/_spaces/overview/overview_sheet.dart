import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/clipboard.dart';
import '../../../_helpers/navigation.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_services/hive/store.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/buttons/close.dart';
import '../../../_widgets/others/empty_box.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/others/divider.dart';
import '../../../_widgets/others/others/scroll.dart';
import '../../../_widgets/others/text.dart';
import '../../../_widgets/sheets/bottom_sheet.dart';
import '../../calendar/_helpers/date_time/date_info.dart';
import '../_helpers/common.dart';
import '../_helpers/prepare.dart';
import '../published/button.dart';
import '_w/delete_btn.dart';
import '_w/members.dart';
import '_w/space_name.dart';
import '_w/space_notfications_tile.dart';

Future<void> showSpaceOverviewBottomSheet() async {
  String spaceId = liveSpace();

  await showAppBottomSheet(
    isFull: true,
    title: spaceNamesBox.get(liveSpace(), defaultValue: 'Untitled'),
    //
    header: Row(
      children: [
        spw(),
        Expanded(child: SpaceName()),
        spw(),
        AppCloseButton(),
      ],
    ),
    //
    content: ValueListenableBuilder(
        valueListenable: storage('info').listenable(),
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
                          if (description.isNotEmpty) Padding(padding: pad(), child: AppText(text: description, faded: true)),
                          description.isNotEmpty ? tph() : sph(),
                          AppButton(
                            leading: 'Starts',
                            trailing: getDayInfoFullNames(spaceData['j'] ?? '...'),
                            expand: true,
                          ),
                          tsph(),
                          AppButton(
                            leading: 'Ends',
                            trailing: getDayInfoFullNames(spaceData['k'] ?? '...'),
                            expand: true,
                          ),
                          tsph(),
                          AppButton(
                            leading: 'Space Id',
                            trailing: spaceId,
                            onPressed: () async => await copyText(spaceId, description: 'Copied space ID.'),
                            expand: true,
                          ),
                          tsph(),
                          SpaceNotificationsTile(),
                          tsph(),
                          //
                          if (isAdmin())
                            AppButton(
                              leading: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AppIcon(Icons.edit, size: medium),
                                  spw(),
                                  Flexible(child: AppText(text: 'Edit Space')),
                                ],
                              ),
                              trailing: AppIcon(Icons.keyboard_arrow_right_rounded, size: 18),
                              onPressed: () => prepareSpaceForEdit(spaceData),
                            ),
                          //
                          if (isAdmin()) mph(),
                          if (isAdmin()) AppText(text: 'Actions', size: small, faded: true),
                          if (isAdmin()) AppDivider(height: mediumHeight()),
                          if (isAdmin())
                            Wrap(
                              spacing: mediumWidth(),
                              runSpacing: smallWidth(),
                              children: [
                                PublishButton(spaceData: spaceData),
                                DeleteSpaceBtn(),
                              ],
                            ),
                          if (isAdmin()) mph(),
                          if (isAdmin()) AppText(text: 'Members', size: small, faded: true),
                          if (isAdmin()) AppDivider(height: mediumHeight()),
                          if (isAdmin()) SpaceMembers(),
                          lpph(),
                          //
                        ],
                      ),
                    ),
                  )
                : EmptyBox(
                    onPressed: () => popWhatsOnTop(todoLast: () => openDrawer()),
                    label: 'Tap to select a space',
                  ),
          );
        }),
  );
}
