import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../_widgets/abcs/dialogs_sheets/bottom_sheet.dart';
import '../../../_widgets/others/others/divider.dart';
import '../../../_widgets/others/others/scroll.dart';
import '../../_notes/_helpers/edit_item.dart';
import '../../_notes/items/date.dart';
import '../published/details.dart';
import '_w/description.dart';
import '_w/group.dart';
import '_w/header.dart';
import '_w/title.dart';

Future<void> showSpaceBottomSheet({required bool isNewSpace}) async {
  await showAppBottomSheet(
    isMinimized: isNewSpace,
    //
    header: Header(isNewSpace),
    //
    content: ListView(
      shrinkWrap: true,
      physics: TopBlockedBouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        //
        TitleInput(isNewSpace),
        //
        sph(),
        //
        Description(),
        //
        msph(),
        //
        Dates(),
        //
        if (isNewSpace) mph(),
        //
        if (isNewSpace) Groups(),
        //
        if (!isNewSpace) AppDivider(height: mediumHeight()),
        //
        if (!isNewSpace) PublishedSpace(),
        //
        lph(),
        //
      ],
    ),
    //
    whenComplete: () => isNewSpace ? null : editItem(),
    //
  );
}
