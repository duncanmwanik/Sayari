import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../_services/hive/local_storage_service.dart';
import 'group_tile.dart';

class GroupList extends StatelessWidget {
  const GroupList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: userGroupsBox.listenable(),
        builder: (context, box, widget) {
          return ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: BouncingScrollPhysics(),
              itemCount: box.length,
              itemBuilder: (context, index) {
                return GroupTile(
                  groupName: box.keyAt(index),
                  groupSpaces: box.getAt(index),
                );
              });
        });
  }
}
