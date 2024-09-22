import 'package:flutter/material.dart';

import 'group_options.dart';
import 'space_tile.dart';
import 'tile.dart';

class GroupTile extends StatelessWidget {
  const GroupTile({super.key, required this.groupName, required this.groupSpaces});

  final String groupName;
  final Map groupSpaces;

  @override
  Widget build(BuildContext context) {
    groupSpaces.removeWhere((key, value) => key.toString() == 'k');

    return Tile(
      title: groupName,
      count: groupSpaces.length,
      trailing: GroupOptions(groupName: groupName),
      child: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: BouncingScrollPhysics(),
          itemCount: groupSpaces.keys.toList().length,
          separatorBuilder: (context, index) => SizedBox(height: 3),
          itemBuilder: (context, index) {
            return SpaceTile(spaceId: groupSpaces.keys.toList()[index], spaceGroupName: groupName);
          }),
    );
  }
}
