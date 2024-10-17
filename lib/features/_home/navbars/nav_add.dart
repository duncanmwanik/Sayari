import 'package:flutter/material.dart';

import '../../../_providers/_providers.dart';
import '../../../_theme/breakpoints.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../../_notes/_helpers/prepare.dart';
import '../../calendar/_helpers/prepare.dart';

class NavAdd extends StatelessWidget {
  const NavAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onPressed: () {
        if (state.views.isCalendar()) createSession();
        if (state.views.isTasks()) createNote(feature.tasks);
        if (state.views.isNotes()) createNote(feature.notes);
      },
      tooltip: 'Add',
      tooltipDirection: AxisDirection.up,
      color: styler.accent,
      padding: EdgeInsets.all(isSmallPC() ? 8 : 12),
      child: AppIcon(Icons.add, color: white),
    );
  }
}
