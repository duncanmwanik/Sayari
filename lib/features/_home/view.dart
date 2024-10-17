import 'package:flutter/material.dart';

import '../../_theme/breakpoints.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/features.dart';
import '../_notes/notes_view.dart';
import '../calendar/session_view.dart';
import '../chat/chat_view.dart';
import '../timeline/timeline.dart';

class AppView extends StatelessWidget {
  const AppView({super.key, required this.view});

  final String view;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: isSmallPC() ? padM('rb') : noPadding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadiusSmall),
      ),
      //
      child: view.isTimeline()
          ? Timeline()
          : view.isCalendar()
              ? SessionsView()
              : view.isNote()
                  ? ListOfItems(type: feature.notes)
                  : view.isTask()
                      ? ListOfItems(type: feature.tasks)
                      : view.isChat()
                          ? ChatView()
                          : Timeline(),
      //
    );
  }
}
