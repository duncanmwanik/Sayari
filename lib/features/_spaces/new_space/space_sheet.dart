import 'package:flutter/material.dart';

import '../../../_helpers/sync/edit_item.dart';
import '../../../_theme/spacing.dart';
import '../../../_widgets/others/others/divider.dart';
import '../../../_widgets/others/others/scroll.dart';
import '../../../_widgets/sheets/bottom_sheet.dart';
import '../../_notes/w/date.dart';
import '../published/details.dart';
import '_w/description.dart';
import '_w/group.dart';
import '_w/header.dart';

Future<void> showSpaceBottomSheet({required bool isNewSpace}) async {
  await showAppBottomSheet(
    isFloater: isNewSpace,
    header: Header(isNewSpace),
    //
    content: ListView(
      shrinkWrap: true,
      physics: TopBlockedBouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        //
        sph(),
        Description(),
        msph(),
        Dates(),
        if (isNewSpace) mph(),
        if (isNewSpace) Groups(),
        if (!isNewSpace) AppDivider(height: mediumHeight()),
        if (!isNewSpace) PublishedSpace(),
        lph(),
        //
      ],
    ),
    //
    whenComplete: () => isNewSpace ? null : editItem(),
    //
  );
}
