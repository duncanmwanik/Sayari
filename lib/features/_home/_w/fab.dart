import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/common/theme.dart';
import '../../../_providers/common/views.dart';
import '../../../_providers/providers.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../../_notes/_helpers/helpers.dart';
import '../../_sessions/_helpers/helpers.dart';
import '../../_tables/_helpers/checks_table.dart';

class HomeFab extends StatelessWidget {
  const HomeFab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ViewsProvider, ThemeProvider>(builder: (context, views, theme, child) {
      bool showFab = !showVertNav() && isATableSelected() && isAdmin() && (views.isSessions() || views.isNotes());

      return Visibility(
        visible: showFab,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50, right: 0),
          child: AppButton(
            onPressed: () {
              if (state.views.isSessions()) {
                prepareSessionCreation();
              } else if (state.views.isNotes()) {
                prepareNoteForCreation();
              }
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
