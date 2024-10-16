import 'package:flutter/material.dart';

import '../../../_models/item.dart';
import '../../../_providers/_providers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/dialogs/app_dialog.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/others/divider.dart';
import '../../../_widgets/others/others/scroll.dart';
import '../../../_widgets/others/text.dart';
import '../../files/_helpers/helper.dart';
import '../../files/file_list.dart';
import '../_helpers/date_time/misc.dart';
import 'session_options.dart';
import 'session_reminders.dart';
import 'session_time.dart';
import 'session_type.dart';

Future showSessionOverviewDialog(Item item) {
  updateSelectedDate(item.id);
  state.input.set(item);
  Map fileMap = getFiles(item.data);

  return showAppDialog(
    showTitleColor: false,
    contentPadding: paddingM('lrb'),
    //
    title: SessionType(item: item),
    //
    content: NoOverScroll(
      child: ListView(
        shrinkWrap: true,
        padding: paddingS('lr'),
        children: [
          // title
          AppText(size: title, text: item.data['t'], weight: FontWeight.bold),
          tph(),
          // time
          SessionTime(startTime: item.data['s'], endTime: item.data['e'] ?? ''),
          // lead
          if (item.data['l'] != null) AppDivider(height: mediumHeight()),
          if (item.data['l'] != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(Icons.person_rounded, size: normal, faded: true),
                spw(),
                Flexible(child: AppText(text: item.data['l'] ?? '', faded: true)),
              ],
            ),
          // venue
          if (item.data['v'] != null) AppDivider(height: mediumHeight()),
          if (item.data['v'] != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(Icons.location_on, size: normal, faded: true),
                spw(),
                Flexible(child: AppText(text: item.data['v'] ?? '', faded: true)),
              ],
            ),
          // reminders
          if (item.data['r'] != null) AppDivider(height: mediumHeight()),
          if (item.data['r'] != null) SessionReminders(reminderString: item.data['r'] ?? ''),
          // description
          if (item.data['a'] != null) AppDivider(height: mediumHeight()),
          if (item.data['a'] != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(Icons.subject_rounded, size: normal, faded: true),
                spw(),
                Flexible(child: AppText(text: item.data['a'] ?? '', faded: true)),
              ],
            ),
          // files
          Visibility(
            visible: fileMap.isNotEmpty,
            child: Padding(
              padding: padding(s: 't'),
              child: FileList(fileData: fileMap, isOverview: true),
            ),
          ),
          //
        ],
      ),
    ),
    //
    actions: [
      SessionOptions(item: item),
    ],
    //
  );
}
