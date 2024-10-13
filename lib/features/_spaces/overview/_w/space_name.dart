import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../__styling/variables.dart';
import '../../../../_services/hive/local_storage_service.dart';
import '../../../../_widgets/others/text.dart';
import '../../_helpers/common.dart';

class SpaceName extends StatelessWidget {
  const SpaceName({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: spaceNamesBox.listenable(),
        builder: (context, box, widget) {
          return AppText(
            size: normal,
            text: liveSpace() != 'none' ? box.get(liveSpace(), defaultValue: 'Untitled') : '',
            bold: true,
          );
        });
  }
}
