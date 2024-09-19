import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../_spaces/_helpers/common.dart';
import '../../_spaces/overview/overview_sheet.dart';

class SpaceName extends StatelessWidget {
  const SpaceName({super.key, this.isMin = false});

  final bool isMin;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: spaceNamesBox.listenable(),
        builder: (context, box, widget) {
          String spaceId = liveSpace();
          bool isASpaceSelected = spaceId != 'none';
          String name = box.get(spaceId, defaultValue: 'Select a space');

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // selected space name
                  Flexible(
                    child: AppButton(
                      onPressed: () => openDrawer(),
                      tooltip: 'Choose Workspace',
                      noStyling: true,
                      isSquare: isMin,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // name
                          if (!isMin)
                            AppText(
                              size: medium,
                              text: name,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              weight: FontWeight.w600,
                            ),
                          //
                          tpw(),
                          AppIcon(Icons.arrow_drop_down, tiny: isMin, faded: true),
                          //
                        ],
                      ),
                    ),
                  ),
                  // workspace settings
                  if (!isMin) tpw(),
                  if (!isMin)
                    AppButton(
                      onPressed: () => isASpaceSelected ? showSpaceOverviewBottomSheet() : openDrawer(),
                      tooltip: 'Manage Workspace',
                      isSquare: true,
                      noStyling: true,
                      child: AppIcon(Icons.menu, faded: true),
                    ),
                  //
                ],
              ),
              // worspace settings
              if (isSmallPC() && isMin) tph(),
              if (isSmallPC() && isMin)
                AppButton(
                  onPressed: () => isASpaceSelected ? showSpaceOverviewBottomSheet() : openDrawer(),
                  tooltip: 'Manage Workspace',
                  isSquare: true,
                  noStyling: true,
                  child: AppIcon(Icons.more_horiz, faded: true),
                ),
              //
            ],
          );
        });
  }
}
