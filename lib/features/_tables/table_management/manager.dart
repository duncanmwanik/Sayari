import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../__styling/spacing.dart';
import '../../../_helpers/user/set_user_data.dart';
import '../../labels/label_manager.dart';
import '../_helpers/table_names.dart';
import '_w/creator_options.dart';
import '_w/group_list.dart';
import '_w/table_list.dart';

class TableManager extends StatelessWidget {
  const TableManager({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('${liveUser()}_data').listenable(),
        builder: (context, box, widget) {
          Map userTableData = box.toMap();
          List groupNames = getGroupNamesAsList(userTableData);

          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(right: 10, left: 10, top: kIsWeb? 5: 30),
            children: [
              //
              CreateOptions(),
              //
              sph(),
              //
              GroupList(userTables: {...userTableData}, groupNames: groupNames),
              //
              TableList(
                  userTableData: {...userTableData}, groupNames: groupNames),
              //
              if (!kIsWeb) LabelManager(isPopup: true),
              //
              spph(),
              //
            ],
          );
        });
  }
}
