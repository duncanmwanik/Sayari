import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/date_time/misc.dart';
import '../../../_providers/common/input.dart';
import '../../../_variables/colors.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/helpers.dart';
import '../session_overview/dialog_session_overview.dart';

class SessionWidgetWeekly extends StatelessWidget {
  const SessionWidgetWeekly({super.key, required this.sessionData, required this.sessionId, required this.sessionDate});

  final Map sessionData;
  final String sessionId;
  final String sessionDate;

  @override
  Widget build(BuildContext context) {
    Color textColor = backgroundColors[sessionData['c']]!.textColor;

    return Consumer<InputProvider>(builder: (context, input, child) {
      return Flexible(
        child: InkWell(
          onTap: () => showSessionOverviewDialog(sessionDate, sessionId, sessionData),
          onLongPress: () => prepareSessionEditing(sessionDate, sessionId, sessionData),
          borderRadius: BorderRadius.circular(borderRadiusTiny),
          child: Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.symmetric(horizontal: 0.1.w, vertical: 0.1.h),
            constraints: BoxConstraints(minHeight: 35, minWidth: double.maxFinite),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadiusTiny),
              color: backgroundColors[sessionData['c']]!.color,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // title
                Flexible(
                  child: AppText(
                    size: small,
                    text: sessionData['t'],
                    overflow: TextOverflow.clip,
                    color: textColor,
                    maxlines: 1,
                  ),
                ),
                // time (show only if screen width is large)
                if (isSmallPC())
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: sessionData['e'] != null ? 7 : 0),
                        child: AppText(size: small, text: get12HourTimeFrom24HourTime(sessionData['s']), color: textColor),
                      ),
                      AppText(
                        size: small,
                        text: (sessionData['e'] != null && sessionData['e'] != '') ? '-  ${get12HourTimeFrom24HourTime(sessionData['e'])}' : '',
                        color: textColor,
                      ),
                    ],
                  ),
                //
              ],
            ),
          ),
        ),
      );
    });
  }
}
