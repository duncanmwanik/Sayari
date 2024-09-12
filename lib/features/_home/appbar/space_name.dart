import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../__styling/variables.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/text.dart';
import '../../_spaces/_helpers/common.dart';
import '../../_spaces/overview/overview_sheet.dart';

class SpaceName extends StatelessWidget {
  const SpaceName({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: spaceNamesBox.listenable(),
        builder: (context, box, widget) {
          String spaceId = liveSpace();
          bool isASpaceSelected = spaceId != 'none';
          String name = box.get(spaceId, defaultValue: 'Select a space');

          return AppButton(
            onPressed: () => isASpaceSelected ? showSpaceOverviewBottomSheet() : openDrawer(),
            tooltip: name,
            noStyling: true,
            borderRadius: borderRadiusCrazy,
            smallVerticalPadding: true,
            child: AppText(
              size: extra,
              text: name,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w800,
            ),
          );
        });
  }
}
