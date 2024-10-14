import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_models/item.dart';
import '../../../_variables/colors.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../files/_helpers/helper.dart';
import '../_helpers/date_time/misc.dart';
import '../_helpers/prepare.dart';
import '../overview/overview.dart';

class DayBox extends StatelessWidget {
  const DayBox({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    Color textColor = backgroundColors[item.color()]!.textColor;
    bool hasFiles = getFiles(item.data).isNotEmpty;
    int fileCount = getFiles(item.data).length;

    return Padding(
      padding: EdgeInsets.only(top: 5, right: 10, left: 10),
      child: AppButton(
        onPressed: () => showSessionOverviewDialog(item),
        onLongPress: () => editSession(item),
        color: backgroundColors[item.color()]!.color,
        padding: EdgeInsets.only(top: 3, bottom: 7, left: 6, right: 4),
        borderRadius: borderRadiusTiny,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title
            AppText(text: item.data['t'], weight: FontWeight.w600, color: textColor),
            //
            Wrap(
              spacing: smallWidth(),
              runSpacing: tinyHeight(),
              children: [
                //
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // start
                    AppText(
                      size: small,
                      text: get12HourTimeFrom24HourTime(item.data['s'], islonger: true),
                      color: textColor,
                      weight: FontWeight.w400,
                    ), // stop
                    AppText(
                      size: small,
                      text: (item.data['e'] != null && item.data['e'] != '')
                          ? '  -  ${get12HourTimeFrom24HourTime(item.data['e'], islonger: true)}'
                          : '',
                      color: textColor,
                      weight: FontWeight.w400,
                    ),
                  ],
                ),
                // lead
                if (item.data['l'] != null)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppIcon(Icons.person_rounded, size: 13, color: textColor),
                      tpw(),
                      Flexible(child: AppText(size: small, text: '${item.data['l']}', color: textColor, weight: FontWeight.w400)),
                    ],
                  ),
                // venue
                if (item.data['v'] != null)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppIcon(Icons.location_on_rounded, size: small, color: textColor),
                      tpw(),
                      Flexible(child: AppText(size: small, text: '${item.data['v']}', color: textColor, weight: FontWeight.w400)),
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
                        weight: FontWeight.w400,
                      )
                    ],
                  ),
                //
              ],
            ),
          ],
        ),
      ),
    );
  }
}
