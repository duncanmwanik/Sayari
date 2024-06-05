import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../_providers/providers.dart';
import '../../../../_variables/features.dart';
import '../../../__styling/spacing.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../features/_tables/_helpers/common.dart';
import '../../abcs/buttons/buttons.dart';
import '../text.dart';

class DevTools extends StatelessWidget {
  const DevTools({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        // AppText(text: 100.w.toString()),
        //
        AppButton(
          onPressed: () => state.views.setHomeView(feature.notes.t),
          noStyling: true,
          child: AppText(text: 'V'),
        ),
        AppButton(
          onPressed: () => Hive.box('${liveTable()}_${feature.notes.t}').clear(),
          noStyling: true,
          child: AppText(text: 'N'),
        ),
        AppButton(
          onPressed: () => Hive.box('${liveTable()}_${feature.notes.t}').clear(),
          noStyling: true,
          child: AppText(text: 'L'),
        ),
        AppButton(
          onPressed: () => Hive.box('${liveTable()}_${feature.finances.t}').clear(),
          noStyling: true,
          child: AppText(text: 'F'),
        ),
        AppButton(
          onPressed: () => Hive.box('${liveTable()}_${feature.sessions.t}').clear(),
          noStyling: true,
          child: AppText(text: 'S'),
        ),
        AppButton(
          onPressed: () => Hive.box('${liveTable()}_${feature.pomodoro.t}').clear(),
          noStyling: true,
          child: AppText(text: 'P'),
        ),
        AppButton(
          onPressed: () => activityVersionBox.clear(),
          noStyling: true,
          child: AppText(text: 'A'),
        ),
        //
        mspw(),
        //
      ],
    );
  }
}
