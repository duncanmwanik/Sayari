import 'package:flutter/material.dart';

import '../../../../_services/hive/local_storage_service.dart';
import 'table_tile.dart';
import 'tile.dart';

class TableList extends StatelessWidget {
  const TableList({super.key, required this.userTableData, required this.groupNames});

  final Map<dynamic, dynamic> userTableData;
  final List groupNames;

  @override
  Widget build(BuildContext context) {
    userTableData.removeWhere((key, value) => !key.toString().startsWith('table'));

    return Tile(
        title: 'All',
        count: userTableData.length,
        iconData: Icons.folder_special_rounded,
        onExpansionChanged: (value) => globalBox.put('keepTableListTileOpen', value),
        initiallyExpanded: globalBox.get('keepTableListTileOpen', defaultValue: true),
        child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: BouncingScrollPhysics(),
            itemCount: userTableData.keys.toList().length,
            separatorBuilder: (context, index) => SizedBox(height: 5),
            itemBuilder: (context, index) {
              String tableId = userTableData.keys.toList()[index];

              return TableTile(tableId: tableId);
            }));
  }
}
