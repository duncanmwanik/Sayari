import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_providers/common/views.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../_sessions/_helpers/helpers.dart';
import '../../_tables/_helpers/checks_table.dart';
import '../../notes/_helpers/helpers.dart';

class WebCreator extends StatelessWidget {
  const WebCreator({super.key, this.isCollapsed = false});

  final bool isCollapsed;

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsProvider>(builder: (context, views, child) {
      bool isSessionsView = views.isSessions();
      bool isNotesView = views.isNotes();

      return AppButton(
        /////////////////////////////////////////////////
        isRound: isCollapsed,
        borderRadius: borderRadiusLarge,
        padding: EdgeInsets.zero,
        noStyling: true,
        onPressed: isATableSelected()
            ? () {
                if (isSessionsView) prepareSessionCreation();
                if (isNotesView) prepareNoteForCreation();
              }
            : () => openDrawer(),
        child: Container(
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: isCollapsed ? 5 : 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadiusLarge),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              transform: GradientRotation(1.5),
              colors: [
                styler.accentColor().withOpacity(0.3),
                styler.accentColor().withOpacity(0.15),
                styler.accentColor().withOpacity(0.05),
              ],
            ),
          ),
          child: isATableSelected()
              ? Row(
                  mainAxisAlignment: isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
                  mainAxisSize: isCollapsed ? MainAxisSize.min : MainAxisSize.max,
                  children: [
                    //
                    AppIcon(Icons.add_circle_rounded, size: 18),
                    if (!isCollapsed) spw(),
                    // if (!isCollapsed) AppText(text: 'Create'),
                    if (!isCollapsed && isNotesView) AppText(text: featureData[views.view]!.createMessage),
                    if (!isCollapsed && !isNotesView) AppText(text: featureData[views.view]!.createMessage),
                    //
                  ],
                )
              : Center(child: AppText(text: 'Select a table', overflow: TextOverflow.ellipsis)),
        ),
      );
    });
  }
}
