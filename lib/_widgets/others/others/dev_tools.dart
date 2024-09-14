import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../_providers/providers.dart';
import '../../../../_variables/features.dart';
import '../../../__styling/spacing.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../features/_spaces/_helpers/common.dart';
import '../../buttons/buttons.dart';
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
          onPressed: () => state.views.setHomeView(feature.items.t),
          noStyling: true,
          child: const AppText(text: 'I'),
        ),
        AppButton(
          onPressed: () => Hive.box('${liveSpace()}_${feature.calendar.t}').clear(),
          noStyling: true,
          child: const AppText(text: 'C'),
        ),
        AppButton(
          onPressed: () => Hive.box('${liveSpace()}_${feature.pomodoro.t}').clear(),
          noStyling: true,
          child: const AppText(text: 'P'),
        ),
        AppButton(
          onPressed: () => activityVersionBox.clear(),
          noStyling: true,
          child: const AppText(text: 'A'),
        ),
        //
        mspw(),
        //
      ],
    );
  }
}
