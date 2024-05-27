import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../__styling/variables.dart';
import '../../../../_services/hive/local_storage_service.dart';
import '../../../../_widgets/others/text.dart';
import '../../_helpers/common.dart';

class TableName extends StatelessWidget {
  const TableName({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: tableNamesBox.listenable(),
        builder: (context, box, widget) {
          return AppText(
            size: extra,
            text: liveTable() != 'none' ? box.get(liveTable(), defaultValue: 'No name') : '',
            fontWeight: FontWeight.w700,
          );
        });
  }
}
