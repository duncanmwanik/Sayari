import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/variables.dart';
import '../../../_models/item.dart';
import '../../../_providers/input.dart';
import '../../../_variables/colors.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/date_time/misc.dart';
import '../_helpers/prepare.dart';
import '../overview/overview.dart';

class WeekBox extends StatelessWidget {
  const WeekBox({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    Color textColor = backgroundColors[item.color()]!.textColor;

    return Consumer<InputProvider>(builder: (context, input, child) {
      return Flexible(
        child: InkWell(
          onTap: () => showSessionOverviewDialog(item),
          onLongPress: () => editSession(item),
          borderRadius: BorderRadius.circular(borderRadiusTiny),
          child: Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.symmetric(horizontal: 0.1.w, vertical: 0.1.h),
            constraints: BoxConstraints(minHeight: 35, minWidth: double.maxFinite),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadiusTiny),
              color: backgroundColors[item.color()]!.color,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // title
                Flexible(
                  child: AppText(
                    size: small,
                    text: item.title(),
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
                        padding: EdgeInsets.only(right: item.data['e'] != null ? 7 : 0),
                        child: AppText(size: 11, text: get12HourTimeFrom24HourTime(item.data['s']), color: textColor),
                      ),
                      Flexible(
                        child: AppText(
                          size: 11,
                          text: (item.data['e'] != null && item.data['e'] != '') ? '-  ${get12HourTimeFrom24HourTime(item.data['e'])}' : '',
                          color: textColor,
                          overflow: TextOverflow.ellipsis,
                        ),
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
