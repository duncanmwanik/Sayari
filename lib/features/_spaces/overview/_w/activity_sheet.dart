import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:styled_text/styled_text.dart';

import '../../../../_services/hive/store.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_theme/variables.dart';
import '../../../../_widgets/buttons/close.dart';
import '../../../../_widgets/others/empty_box.dart';
import '../../../../_widgets/others/others/divider.dart';
import '../../../../_widgets/others/others/scroll.dart';
import '../../../../_widgets/others/text.dart';
import '../../../../_widgets/sheets/bottom_sheet.dart';
import '../../../calendar/_helpers/date_time/misc.dart';
import 'dialog_space_activity.dart';

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
        valueListenable: storage('activity').listenable(),
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
                        style: GoogleFonts.inter(color: styler.textColor(), fontWeight: FontWeight.normal, fontSize: medium),
                        tags: {
                          'b': StyledTextTag(
                              style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: styler.textColor(), fontSize: medium)),
                        },
                      ),
                      subtitle: AppText(size: small, text: date, weight: FontWeight.w400, faded: true),
                    );
                  })
              //
              : EmptyBox(label: 'No new activity');
          //
        }),
  );
}
