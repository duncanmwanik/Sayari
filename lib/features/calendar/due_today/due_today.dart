import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/extentions/dateTime.dart';
import '../../../_models/item.dart';
import '../../../_services/hive/store.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/date_time/misc.dart';
import '../_helpers/prepare.dart';
import '../_helpers/sort.dart';
import '../w/daily_box.dart';

class DueToday extends StatelessWidget {
  const DueToday({super.key});

  @override
  Widget build(BuildContext context) {
    String date = now().part();

    return AppButton(
      margin: padL('tb'),
      padding: padM(),
      color: styler.appColor(0.3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  pw(2),
                  AppIcon(FontAwesomeIcons.solidCalendarDays, size: small, faded: true),
                  spw(),
                  Flexible(child: AppText(text: 'Today - ', faded: true)),
                  tpw(),
                  Flexible(child: AppText(text: getDateFull(now().part()), faded: true)),
                ],
              ),
              //
              Spacer(),
              // new session
              AppButton(
                onPressed: () => createSession(date: now().part(), hour: now().hour),
                svp: true,
                isSquare: true,
                faded: true,
                leading: Icons.add,
              )
              //
            ],
          ),
          mph(),
          //
          ValueListenableBuilder(
              valueListenable: storage(feature.calendar).listenable(keys: [date]),
              builder: (context, box, widget) {
                Map todaySessionsMap = sortSessions(box.get(date, defaultValue: {}));

                return todaySessionsMap.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(todaySessionsMap.length, (index) {
                          String id = todaySessionsMap.keys.toList()[index];
                          Item item = Item(
                            parent: feature.calendar,
                            type: feature.calendar,
                            id: date,
                            sid: id,
                            data: todaySessionsMap[id],
                          );

                          return DayBox(item: item);
                        }),
                      )
                    : Padding(padding: padL('lb'), child: AppText(text: 'No sessions today...', extraFaded: true));
              }),
          //
        ],
      ),
    );
  }
}
