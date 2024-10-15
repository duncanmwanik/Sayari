import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/navigation.dart';
import '../../_services/hive/local_storage_service.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';
import '../_spaces/_helpers/common.dart';
import '../_spaces/overview/overview_sheet.dart';

class SpaceName extends StatelessWidget {
  const SpaceName({super.key, this.isMin = false});

  final bool isMin;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: globalBox.listenable(),
        builder: (context, box, widget) {
          String spaceId = liveSpace();
          bool isASpaceSelected = spaceId != 'none';

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // selected space name
                  if (!isMin)
                    Flexible(
                      child: AppButton(
                        onPressed: () => openDrawer(),
                        tooltip: 'View All Spaces',
                        noStyling: !isSmallPC(),
                        showBorder: isSmallPC(),
                        borderWidth: 0.3,
                        color: styler.appColor(0.5),
                        isSquare: isMin,
                        srp: !isMin,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // name
                            ValueListenableBuilder(
                                valueListenable: spaceNamesBox.listenable(),
                                builder: (context, box, widget) {
                                  String name = box.get(spaceId, defaultValue: 'Select a space');
                                  return AppText(
                                      text: name, textAlign: TextAlign.start, weight: FontWeight.w600, overflow: TextOverflow.ellipsis);
                                }),
                            //
                            AppIcon(Icons.arrow_drop_down, tiny: isMin, faded: true),
                            //
                          ],
                        ),
                      ),
                    ),
                  if (!isMin) AppText(size: medium, text: ' |', weight: FontWeight.w400, extraFaded: true),
                  // workspace settings
                  if (!isMin)
                    AppButton(
                      onPressed: () => isASpaceSelected ? showSpaceOverviewBottomSheet() : openDrawer(),
                      tooltip: 'Manage Space',
                      isSquare: true,
                      noStyling: true,
                      child: AppIcon(Icons.more_horiz, faded: true),
                    ),
                  //
                ],
              ),
              // worspace
              if (isSmallPC() && isMin) tph(),
              if (isSmallPC() && isMin)
                AppButton(
                  onPressed: () => openDrawer(),
                  tooltip: 'Choose Space',
                  color: styler.accentColor(1),
                  isSquare: true,
                  child: AppIcon(Icons.arrow_drop_down, faded: true),
                ),
              // worspace settings
              if (isSmallPC() && isMin) tph(),
              if (isSmallPC() && isMin)
                AppButton(
                  onPressed: () => isASpaceSelected ? showSpaceOverviewBottomSheet() : openDrawer(),
                  tooltip: 'Manage Space',
                  isSquare: true,
                  noStyling: true,
                  child: AppIcon(moreIcon, faded: true),
                ),
              //
            ],
          );
        });
  }
}
