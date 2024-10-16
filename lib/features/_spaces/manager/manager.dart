import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../_services/hive/local_storage_service.dart';
import '../../../_theme/spacing.dart';
import '_w/creator_options.dart';
import '_w/group_list.dart';
import '_w/space_list.dart';

class SpaceManager extends StatelessWidget {
  const SpaceManager({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: userSpacesBox.listenable(),
        builder: (context, box, widget) {
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(right: 10, left: 10, top: kIsWeb ? 8 : 30),
            children: [
              //
              CreateOptions(),
              sph(),
              GroupList(),
              SpaceList(),
              spph(),
              //
            ],
          );
        });
  }
}
