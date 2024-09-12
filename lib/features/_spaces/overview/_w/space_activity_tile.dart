import 'package:flutter/material.dart';

import '../../../../__styling/spacing.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/others/list_tile.dart';
import '../../../../_widgets/others/text.dart';
import '../activity_sheet.dart';

class SpaceActivityTile extends StatelessWidget {
  const SpaceActivityTile({super.key});

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      onTap: () => showActivityBottomSheet(),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppIcon(Icons.history_rounded, size: 18),
          spw(),
          Flexible(
              child: AppText(
            text: 'Activity History',
          )),
        ],
      ),
      trailing: AppIcon(Icons.keyboard_arrow_right_rounded, size: 18),
    );
  }
}
