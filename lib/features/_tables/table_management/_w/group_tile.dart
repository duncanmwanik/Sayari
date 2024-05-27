import 'package:flutter/material.dart';

import 'group_options.dart';
import 'table_tile.dart';
import 'tile.dart';

class GroupTile extends StatelessWidget {
  const GroupTile({super.key, required this.groupName, required this.groupTables, required this.groupNames});

  final String groupName;
  final Map groupTables;
  final List groupNames;

  @override
  Widget build(BuildContext context) {
    groupTables.removeWhere((key, value) => !key.toString().startsWith('table'));

    return Tile(
      title: groupName,
      count: groupTables.length,
      trailing: GroupOptions(groupName: groupName),
      child: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: BouncingScrollPhysics(),
          itemCount: groupTables.keys.toList().length,
          separatorBuilder: (context, index) => SizedBox(height: 3),
          itemBuilder: (context, index) {
            return TableTile(tableId: groupTables.keys.toList()[index], tableGroupName: groupName);
          }),
    );
  }
}
