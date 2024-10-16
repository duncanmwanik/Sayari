import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../_models/item.dart';
import '../../../_services/hive/store.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/empty_box.dart';
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
    String date = getDatePart(DateTime.now());

    return Padding(
      padding: paddingL('tb'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppIcon(Icons.calendar_month, size: normal, faded: true),
                  spw(),
                  AppText(text: 'Due Today', faded: true),
                ],
              ),
              //
              Spacer(),
              // new session
              AppButton(
                onPressed: () => createSession(date: nowDate(), hour: nowHour()),
                svp: true,
                isSquare: true,
                noStyling: true,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppIcon(Icons.add, size: normal, faded: true),
                    spw(),
                    AppText(text: 'New', size: small, faded: true),
                  ],
                ),
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
                    : EmptyBox(label: 'All clear today', centered: false, showImage: false);
              }),
          //
        ],
      ),
    );
  }
}
