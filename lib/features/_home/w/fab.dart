import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_providers/_providers.dart';
import '../../../_providers/theme.dart';
import '../../../_providers/views.dart';
import '../../../_theme/breakpoints.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../../_notes/_helpers/prepare.dart';
import '../../_spaces/_helpers/common.dart';
import '../../calendar/_helpers/prepare.dart';

class HomeFab extends StatelessWidget {
  const HomeFab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ViewsProvider, ThemeProvider>(builder: (context, views, theme, child) {
      bool showFab = isPhone() && isASpaceSelected() && isAdmin() && (views.isCalendar() || views.isNotes());

      return Visibility(
        visible: showFab,
        child: Padding(
          padding: EdgeInsets.only(bottom: 50, right: 0),
          child: AppButton(
            onPressed: () {
              if (state.views.isCalendar()) createSession();
              if (state.views.isTasks()) createNote(feature.tasks);
              if (state.views.isNotes()) createNote(feature.notes);
            },
            height: 50,
            width: 50,
            padding: EdgeInsets.zero,
            color: Color.alphaBlend(styler.accentColor(9), styler.navColor()),
            borderRadius: borderRadiusMediumSmall,
            child: AppIcon(Icons.add, size: 30, color: white),
          ),
        ),
      );
    });
  }
}
