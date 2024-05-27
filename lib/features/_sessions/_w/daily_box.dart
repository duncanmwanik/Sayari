import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/date_time/misc.dart';
import '../../../_variables/colors.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../files/_helpers/helper.dart';
import '../../files/file_list.dart';
import '../_helpers/helpers.dart';
import '../session_overview/dialog_session_overview.dart';

class DailyBox extends StatelessWidget {
  const DailyBox({super.key, required this.sessionData, required this.sessionId, required this.sessionDate});
  final Map sessionData;
  final String sessionId;
  final String sessionDate;

  @override
  Widget build(BuildContext context) {
    Color textColor = backgroundColors[sessionData['c']]!.textColor;

    return Theme(
      data: ThemeData(
        splashColor: transparent,
        hoverColor: transparent,
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 5, right: 10, left: 10),
        child: Material(
          color: transparent,
          child: ListTile(
            onTap: () => showSessionOverviewDialog(sessionDate, sessionId, sessionData),
            onLongPress: () => prepareSessionEditing(sessionDate, sessionId, sessionData),
            tileColor: backgroundColors[sessionData['c']]!.color,
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusSmall)),
            dense: true,
            visualDensity: VisualDensity(vertical: -1),
            title: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: smallWidth(),
              runSpacing: tinyHeight(),
              children: [
                // title
                AppText(text: sessionData['t'], fontWeight: FontWeight.w700, color: textColor),
                // type
                Container(
                  margin: EdgeInsets.only(bottom: 2),
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadiusMedium),
                    border: Border.all(color: textColor.withOpacity(0.3)),
                  ),
                  child: AppText(size: tiny, text: sessionData['y'], color: textColor),
                ),
                //
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // time
                Row(
                  children: [
                    // start
                    AppText(
                      size: small,
                      text: get12HourTimeFrom24HourTime(sessionData['s'], islonger: true),
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ), // stop
                    AppText(
                      size: small,
                      text: (sessionData['e'] != null && sessionData['e'] != '') ? '  -  ${get12HourTimeFrom24HourTime(sessionData['e'], islonger: true)}' : '',
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                //
                tph(),
                //
                Wrap(
                  spacing: smallWidth(),
                  runSpacing: tinyHeight(),
                  children: [
                    // lead
                    if (sessionData['l'] != null)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppIcon(Icons.person_rounded, size: 14, color: textColor),
                          tpw(),
                          Flexible(child: AppText(size: small, text: '${sessionData['l']}', color: textColor)),
                        ],
                      ),
                    // venue
                    if (sessionData['v'] != null)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppIcon(Icons.location_on_rounded, size: 12.2, color: textColor),
                          tpw(),
                          Flexible(child: AppText(size: small, text: '${sessionData['v']}', color: textColor)),
                        ],
                      ),
                    // files
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FileList(fileData: getFiles(sessionData), isOverview: true),
                      ],
                    ),
                    //
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
