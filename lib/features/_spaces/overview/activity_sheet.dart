import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:styled_text/styled_text.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/date_time/misc.dart';
import '../../../_widgets/abcs/buttons/close_button.dart';
import '../../../_widgets/abcs/dialogs_sheets/bottom_sheet.dart';
import '../../../_widgets/others/empty_box.dart';
import '../../../_widgets/others/others/divider.dart';
import '../../../_widgets/others/others/scroll.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/common.dart';
import '_w/dialog_space_activity.dart';

Future<void> showActivityBottomSheet() async {
  await showAppBottomSheet(
    //
    header: Row(
      children: [
        AppCloseButton(isX: false),
        spw(),
        Flexible(child: AppText(size: normal, text: 'Activity History')),
      ],
    ),
    //
    content: ValueListenableBuilder(
        valueListenable: Hive.box('${liveSpace()}_activity').listenable(),
        builder: (context, box, widget) {
          List activities = box.keys.toList().reversed.toList();
          //
          return box.keys.toList().isNotEmpty
              ? ListView.separated(
                  shrinkWrap: true,
                  physics: TopBlockedBouncingScrollPhysics(),
                  itemCount: box.keys.toList().length,
                  separatorBuilder: (context, index) => AppDivider(height: 1),
                  itemBuilder: (BuildContext context, int index) {
                    String timestamp = activities[index];
                    String activityText = box.get(timestamp) ?? 'Recent changes were made';
                    String date = getTimeFromTimestamp(timestamp);

                    return ListTile(
                      dense: true,
                      onLongPress: () => showSpaceActivityDialog(timestamp),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusSmall)),
                      title: StyledText(
                        text: activityText,
                        style: TextStyle(color: styler.textColor(), fontWeight: FontWeight.normal, fontSize: medium),
                        tags: {
                          'b': StyledTextTag(style: TextStyle(fontWeight: FontWeight.bold, color: styler.textColor(), fontSize: medium)),
                        },
                      ),
                      subtitle: AppText(size: small, text: date, fontWeight: FontWeight.w400, faded: true),
                    );
                  })
              //
              : EmptyBox(label: 'No new activity');
          //
        }),
  );
}
