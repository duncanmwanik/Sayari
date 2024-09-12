import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../_helpers/actions.dart';
import '../_helpers/helpers.dart';

class SessionOptions extends StatelessWidget {
  const SessionOptions({super.key, required this.sessionDate, required this.sessionId, required this.sessionData});

  final String sessionDate;
  final String sessionId;
  final Map sessionData;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: smallWidth(),
      runSpacing: smallWidth(),
      alignment: WrapAlignment.end,
      children: [
        //
        AppButton(
          onPressed: () {
            popWhatsOnTop(); // close overview dialog
            prepareSessionEditing(sessionDate, sessionId, sessionData);
          },
          tooltip: 'Edit Session',
          noStyling: true,
          isSquare: true,
          child: AppIcon(Icons.edit_rounded, faded: true, size: 18),
        ),
        //
        AppButton(
          onPressed: () {
            copySessionToDates(previousDate: sessionDate, sessionId: sessionId, sessionData: sessionData, move: false);
          },
          tooltip: 'Copy to Date',
          noStyling: true,
          isSquare: true,
          child: AppIcon(Icons.copy_rounded, faded: true, size: 18),
        ),
        //
        AppButton(
          onPressed: () {
            copySessionToDates(previousDate: sessionDate, sessionId: sessionId, sessionData: sessionData, move: true);
          },
          tooltip: 'Move To Date',
          noStyling: true,
          isSquare: true,
          child: AppIcon(Icons.forward_rounded, faded: true, size: 18),
        ),
        //
        AppButton(
          onPressed: () {
            deleteSession(sessionDate: sessionDate, sessionId: sessionId, sessionName: sessionData['t'], sessionData: sessionData);
          },
          tooltip: 'Delete Session',
          noStyling: true,
          isSquare: true,
          child: AppIcon(Icons.delete_forever_rounded, faded: true, size: 18),
        ),
        //
      ],
    );
  }
}
