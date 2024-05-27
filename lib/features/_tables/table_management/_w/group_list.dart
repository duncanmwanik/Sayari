import 'package:flutter/material.dart';

import 'group_tile.dart';

class GroupList extends StatelessWidget {
  const GroupList({super.key, required this.userTables, required this.groupNames});

  final Map<dynamic, dynamic> userTables;
  final List groupNames;

  @override
  Widget build(BuildContext context) {
    userTables.removeWhere((key, value) => key.toString().startsWith('table'));

    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: BouncingScrollPhysics(),
        itemCount: userTables.keys.toList().length,
        itemBuilder: (context, index) {
          String key = userTables.keys.toList()[index];

          return GroupTile(
            groupName: key,
            groupTables: userTables[key],
            groupNames: groupNames,
          );
        });
  }
}
