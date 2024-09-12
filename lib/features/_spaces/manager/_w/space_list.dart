import 'package:flutter/material.dart';

import '../../../../_services/hive/local_storage_service.dart';
import 'space_tile.dart';
import 'tile.dart';

class SpaceList extends StatelessWidget {
  const SpaceList({super.key, required this.userSpaceData, required this.groupNames});

  final Map<dynamic, dynamic> userSpaceData;
  final List groupNames;

  @override
  Widget build(BuildContext context) {
    userSpaceData.removeWhere((key, value) => !key.toString().startsWith('space'));

    return Tile(
        title: 'All',
        count: userSpaceData.length,
        iconData: Icons.folder_special_rounded,
        onExpansionChanged: (value) => globalBox.put('keepSpaceListTileOpen', value),
        initiallyExpanded: globalBox.get('keepSpaceListTileOpen', defaultValue: true),
        child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: BouncingScrollPhysics(),
            itemCount: userSpaceData.keys.toList().length,
            separatorBuilder: (context, index) => SizedBox(height: 5),
            itemBuilder: (context, index) {
              String spaceId = userSpaceData.keys.toList()[index];

              return SpaceTile(spaceId: spaceId);
            }));
  }
}
