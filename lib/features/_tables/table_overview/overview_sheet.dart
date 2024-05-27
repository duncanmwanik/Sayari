import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../__styling/spacing.dart';
import '../../../_helpers/_common/misc.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_helpers/date_time/date_info.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/abcs/dialogs_sheets/bottom_sheet.dart';
import '../../../_widgets/others/empty_box.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/others/list_tile.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/checks_table.dart';
import '../_helpers/common.dart';
import '../_helpers/helpers.dart';
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
          Map tableInfo = box.toMap();
          String description = tableInfo['a'] ?? '';

          return tableId != 'none'
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      //
                      if (description.isNotEmpty) TableDescription(tableDescription: description),
                      //
                      kIsWeb ? sph() : tsph(),
                      //
                      AppListTile(
                        leading: 'Starts',
                        trailing: getDayInfoFullNames(tableInfo['j'] ?? '...'),
                      ),
                      //
                      kIsWeb ? sph() : tsph(),
                      //
                      AppListTile(
                        leading: 'Ends',
                        trailing: getDayInfoFullNames(tableInfo['k'] ?? '...'),
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
                      TableOwnerTile(ownerId: tableInfo['o'] ?? '-'),
                      //
                      kIsWeb ? sph() : tsph(),
                      //
                      TableNotificationsTile(tableName: tableInfo['t'] ?? '-'),
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
                              AppIcon(Icons.edit_rounded, size: 14),
                              SizedBox(width: smallWidth()),
                              Flexible(child: AppText(text: 'Edit Table')),
                            ],
                          ),
                          trailing: AppIcon(Icons.keyboard_arrow_right_rounded, size: 18),
                          onTap: () => prepareTableForEdit(tableInfo),
                        ),
                      //
                      kIsWeb ? sph() : tsph(),
                      //
                    ],
                  ),
                )
              : EmptyBox(
                  onPressed: () {
                    popWhatsOnTop();
                    openDrawer();
                  },
                  label: 'Tap to select a table',
                );
        }),
  );
}
