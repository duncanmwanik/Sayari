import 'package:flutter/material.dart';

import '../../../../_widgets/buttons/button.dart';
import 'activity_sheet.dart';

class SpaceActivityTile extends StatelessWidget {
  const SpaceActivityTile({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onPressed: () => showActivityBottomSheet(),
      leading: Icons.manage_history_rounded,
      content: 'Activity History',
      trailing: Icons.keyboard_arrow_right_rounded,
    );
  }
}
