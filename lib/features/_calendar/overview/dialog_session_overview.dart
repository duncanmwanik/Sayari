import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/date_time/misc.dart';
import '../../../_providers/providers.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/abcs/dialogs_sheets/app_dialog.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/others/divider.dart';
import '../../../_widgets/others/others/scroll.dart';
import '../../../_widgets/others/text.dart';
import '../../files/_helpers/helper.dart';
import '../../files/file_list.dart';
import 'session_options.dart';
import 'session_reminders.dart';
import 'session_time.dart';
import 'session_type.dart';

Future showSessionOverviewDialog(String sessionDate, String sessionId, Map sessionData) {
  updateSelectedDate(sessionDate);
  state.input.setInputData(isNw: false, typ: feature.calendar.t, id: sessionId, dta: sessionData);
  Map fileMap = getFiles(sessionData);

  return showAppDialog(
    //
    smallTitlePadding: true,
    //
    title: SessionType(sessionsType: sessionData['y'], sessionColor: sessionData['c']),
    //
    content: NoOverScroll(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          // title
          AppText(size: title, text: sessionData['t'], fontWeight: FontWeight.w700),
          tph(),
          // time
          SessionTime(startTime: sessionData['s'], endTime: sessionData['e'] ?? ''),
          // lead
          if (sessionData['l'] != null) AppDivider(),
          if (sessionData['l'] != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(Icons.person_rounded, size: normal, faded: true),
                spw(),
                Flexible(child: AppText(text: sessionData['l'] ?? '', faded: true)),
              ],
            ),
          // venue
          if (sessionData['v'] != null) AppDivider(),
          if (sessionData['v'] != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(Icons.location_on, size: normal, faded: true),
                spw(),
                Flexible(child: AppText(text: sessionData['v'] ?? '', faded: true)),
              ],
            ),
          // reminders
          if (sessionData['r'] != null) AppDivider(),
          if (sessionData['r'] != null) SessionReminders(reminderString: sessionData['r'] ?? ''),
          // description
          if (sessionData['a'] != null) AppDivider(),
          if (sessionData['a'] != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(Icons.subject_rounded, size: normal, faded: true),
                spw(),
                Flexible(child: AppText(text: sessionData['a'] ?? '', faded: true)),
              ],
            ),
          // files
          Visibility(
            visible: fileMap.isNotEmpty,
            child: Padding(
              padding: itemPadding(top: true),
              child: FileList(fileData: fileMap),
            ),
          ),
          //
        ],
      ),
    ),
    //
    actions: [
      SessionOptions(sessionDate: sessionDate, sessionId: sessionId, sessionData: sessionData),
    ],
    //
  );
}
