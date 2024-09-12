import 'package:flutter/material.dart';

import 'group_tile.dart';

class GroupList extends StatelessWidget {
  const GroupList({super.key, required this.userSpaces, required this.groupNames});

  final Map<dynamic, dynamic> userSpaces;
  final List groupNames;

  @override
  Widget build(BuildContext context) {
    userSpaces.removeWhere((key, value) => key.toString().startsWith('space'));

    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: BouncingScrollPhysics(),
        itemCount: userSpaces.keys.toList().length,
        itemBuilder: (context, index) {
          String key = userSpaces.keys.toList()[index];

          return GroupTile(
            groupName: key,
            groupSpaces: userSpaces[key],
            groupNames: groupNames,
          );
        });
  }
}
