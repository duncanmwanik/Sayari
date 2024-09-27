import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/navigation.dart';
import '../../../_models/item.dart';
import '../../../_services/hive/get_data.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/buttons/close.dart';
import '../../../_widgets/others/empty_box.dart';
import '../../../_widgets/others/others/divider.dart';
import '../../../_widgets/others/text.dart';
import '../../_spaces/_helpers/checks_space.dart';
import '../_helpers/date_time/date_info.dart';
import '../_helpers/prepare.dart';
import '../_helpers/sort.dart';
import 'daily_box.dart';

List<Widget> sessionListMenu(String date) {
  Map todaySessionsMap = sortSessions(storage(feature.calendar).get(date, defaultValue: {}));

  return [
    //
    Row(
      children: [
        //
        Expanded(
          child: Row(
            children: [
              AppCloseButton(),
              tpw(),
              Flexible(child: AppText(size: small, text: getDayInfoFullNames(date))),
            ],
          ),
        ),
        //
        tpw(),
        if (isASpaceSelected() && isAdmin())
          AppButton(
            onPressed: () {
              popWhatsOnTop(); // close menu
              createSession(date: date, hour: TimeOfDay.now().hour);
            },
            tooltip: 'Create Session Today',
            noStyling: true,
            isSquare: true,
            iconSize: 22,
            leading: Icons.add_rounded,
          ),
        //
      ],
    ),
    //
    AppDivider(height: smallHeight()),
    //
    todaySessionsMap.isNotEmpty
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
        : EmptyBox(label: 'No sessions today', showImage: false),
    //
    sph(),
    //
  ];
}
