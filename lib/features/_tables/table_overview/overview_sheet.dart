import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/misc.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_helpers/date_time/date_info.dart';
import '../../../_widgets/abcs/buttons/close_button.dart';
import '../../../_widgets/abcs/dialogs_sheets/bottom_sheet.dart';
import '../../../_widgets/others/empty_box.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/others/divider.dart';
import '../../../_widgets/others/others/list_tile.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/checks_table.dart';
import '../_helpers/common.dart';
import '../_helpers/helpers.dart';
import '../new_table/_w/publish_btn.dart';
import '_w/table_about.dart';
import '_w/table_admin_tile.dart';
import '_w/table_name.dart';
import '_w/table_notfications_tile.dart';
import '_w/table_owner_tile.dart';

Future<void> showTableOverviewBottomSheet() async {
  String tableId = liveTable();

  await showAppBottomSheet(
    //
    header: Row(
      children: [
        AppCloseButton(),
        spw(),
        Expanded(child: TableName()),
      ],
    ),
    //
    content: ValueListenableBuilder(
        valueListenable: Hive.box('${liveTable()}_info').listenable(),
        builder: (context, box, widget) {
          Map spaceData = box.toMap();
          String description = spaceData['a'] ?? '';

          return tableId != 'none'
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //
                      if (description.isNotEmpty) TableDescription(tableDescription: description),
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
                        leading: 'Table Id',
                        trailing: tableId,
                        onTap: () async => await copyToClipboard(tableId),
                      ),
                      //
                      kIsWeb ? sph() : tsph(),
                      //
                      TableOwnerTile(ownerId: spaceData['o'] ?? '-'),
                      //
                      kIsWeb ? sph() : tsph(),
                      //
                      TableNotificationsTile(tableName: spaceData['t'] ?? '-'),
                      //
                      kIsWeb ? sph() : tsph(),
                      //
                      TableAdminTile(),
                      //
                      kIsWeb ? sph() : tsph(),
                      //
                      if (isAdmin())
                        AppListTile(
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppIcon(Icons.settings, size: 14),
                              spw(),
                              Flexible(child: AppText(text: 'Manage Workspace')),
                            ],
                          ),
                          trailing: AppIcon(Icons.keyboard_arrow_right_rounded, size: 18),
                          onTap: () => prepareTableForEdit(spaceData),
                        ),
                      //
                      mph(),
                      //
                      AppText(text: 'Other Actions', size: small, faded: true),
                      //
                      AppDivider(height: mediumHeight()),
                      //
                      PublishButton(spaceData: spaceData),
                      //
                    ],
                  ),
                )
              : EmptyBox(
                  onPressed: () {
                    popWhatsOnTop();
                    openDrawer();
                  },
                  label: 'Tap to select a space',
                );
        }),
  );
}
