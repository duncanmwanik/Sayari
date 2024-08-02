import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../__styling/variables.dart';
import '../../_helpers/_common/navigation.dart';
import '../../_services/hive/local_storage_service.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/others/text.dart';
import '../_tables/_helpers/common.dart';
import '../_tables/table_overview/overview_sheet.dart';

class TableName extends StatelessWidget {
  const TableName({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: tableNamesBox.listenable(),
        builder: (context, box, widget) {
          String tableId = liveTable();
          bool isATableSelected = tableId != 'none';
          String name = box.get(tableId, defaultValue: 'Select a table');

          return AppButton(
            onPressed: () => isATableSelected ? showTableOverviewBottomSheet() : openDrawer(),
            tooltip: name,
            noStyling: true,
            borderRadius: borderRadiusCrazy,
            smallVerticalPadding: true,
            child: AppText(
              size: extra,
              text: name,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w800,
            ),
          );
        });
  }
}
