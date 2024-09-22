import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../_services/hive/local_storage_service.dart';
import 'space_tile.dart';
import 'tile.dart';

class SpaceList extends StatelessWidget {
  const SpaceList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: userSpacesBox.listenable(),
        builder: (context, box, widget) {
          return Tile(
              title: 'All',
              count: box.length,
              iconData: Icons.folder_special_rounded,
              onExpansionChanged: (value) => globalBox.put('keepSpaceListTileOpen', value),
              initiallyExpanded: globalBox.get('keepSpaceListTileOpen', defaultValue: true),
              child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: BouncingScrollPhysics(),
                  itemCount: box.length,
                  separatorBuilder: (context, index) => SizedBox(height: 5),
                  itemBuilder: (context, index) {
                    return SpaceTile(spaceId: box.keyAt(index));
                  }));
        });
  }
}
