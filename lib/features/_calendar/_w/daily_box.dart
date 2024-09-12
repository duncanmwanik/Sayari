import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/date_time/misc.dart';
import '../../../_variables/colors.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../files/_helpers/helper.dart';
import '../_helpers/helpers.dart';
import '../overview/dialog_session_overview.dart';

class DailyBox extends StatelessWidget {
  const DailyBox({super.key, required this.sessionData, required this.sessionId, required this.sessionDate});
  final Map sessionData;
  final String sessionId;
  final String sessionDate;

  @override
  Widget build(BuildContext context) {
    Color textColor = backgroundColors[sessionData['c']]!.textColor;
    bool hasFiles = getFiles(sessionData).isNotEmpty;
    int fileCount = getFiles(sessionData).length;

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
            title: AppText(text: sessionData['t'], fontWeight: FontWeight.w700, color: textColor),
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
                      fontWeight: FontWeight.w400,
                    ), // stop
                    AppText(
                      size: small,
                      text: (sessionData['e'] != null && sessionData['e'] != '')
                          ? '  -  ${get12HourTimeFrom24HourTime(sessionData['e'], islonger: true)}'
                          : '',
                      color: textColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
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
                          AppIcon(Icons.person_rounded, size: 13, color: textColor),
                          tpw(),
                          Flexible(child: AppText(size: small, text: '${sessionData['l']}', color: textColor, fontWeight: FontWeight.w400)),
                        ],
                      ),
                    // venue
                    if (sessionData['v'] != null)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppIcon(Icons.location_on_rounded, size: small, color: textColor),
                          tpw(),
                          Flexible(child: AppText(size: small, text: '${sessionData['v']}', color: textColor, fontWeight: FontWeight.w400)),
                        ],
                      ),
                    // files
                    if (hasFiles)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppIcon(Icons.attach_file_rounded, color: textColor, size: small),
                          tpw(),
                          AppText(
                            text: '$fileCount file${fileCount > 1 ? 's' : ''} attached',
                            color: textColor,
                            size: small,
                            fontWeight: FontWeight.w400,
                          )
                        ],
                      )
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
