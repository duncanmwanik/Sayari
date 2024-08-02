import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_widgets/abcs/dialogs_sheets/bottom_sheet.dart';
import '../../../_widgets/items/date.dart';
import '../../../_widgets/others/others/divider.dart';
import '../../../_widgets/others/others/scroll.dart';
import '../../_notes/_helpers/edit_item.dart';
import '_w/description.dart';
import '_w/group.dart';
import '_w/header.dart';
import '_w/publish.dart';
import '_w/title.dart';

Future<void> showTableBottomSheet({required bool isNewTable}) async {
  await showAppBottomSheet(
    //
    header: Header(isNewTable: isNewTable),
    //
    content: ListView(
      shrinkWrap: true,
      physics: TopBlockedBouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        //
        Image.asset('assets/images/sayari.png', height: imageSizeMedium),
        //
        TitleInput(isNewTable: isNewTable),
        //
        sph(),
        //
        Description(),
        //
        msph(),
        //
        Dates(),
        //
        if (isNewTable) mph(),
        //
        if (isNewTable) Groups(),
        //
        if (!isNewTable) AppDivider(height: mediumHeight()),
        //
        if (!isNewTable) PublishedSpace(),
        //
      ],
    ),
    //
    whenComplete: () => isNewTable ? null : editItem(),
    //
  );
}
