import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/abcs/dialogs_sheets/bottom_sheet.dart';
import '../../../_widgets/others/text.dart';
import '../../files/_helpers/upload.dart';
import '../../files/image.dart';
import '../_helpers/common.dart';
import '../table_overview/_w/table_about.dart';
import '../table_overview/_w/table_name.dart';

Future<void> showPublishBookBottomSheet() async {
  await showAppBottomSheet(
    //
    header: Row(
      children: [
        AppCloseButton(),
        spw(),
        Expanded(child: AppText(text: 'Publish book')),
      ],
    ),
    //
    content: ValueListenableBuilder(
        valueListenable: Hive.box('${liveTable()}_info').listenable(),
        builder: (context, box, widget) {
          Map tableInfo = box.toMap();
          String description = tableInfo['a'] ?? '';
          String fileId = '';
          String fileName = '';

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                kIsWeb ? sph() : tsph(),
                //
                AppButton(
                  onPressed: () async {
                    await getFilesToUpload(allowMultiple: false, imagesOnly: true).then((fileMap) {
                      if (fileMap.isNotEmpty) {
                        // state.input.update(action: 'remove', key: fileId);
                        // state.input.update(action: 'add', key: 'wuf', value: fileMap['fileId']);
                      }
                    });
                  },
                  padding: EdgeInsets.all(3),
                  borderRadius: borderRadiusTiny,
                  child: ImageFile(
                    fileId,
                    fileName,
                    {fileId: fileName},
                    isLinks: true,
                    radius: borderRadiusTiny,
                    size: 80,
                  ),
                ),
                //
                mph(),
                //
                TableName(),
                //
                kIsWeb ? sph() : tsph(),
                //
                if (description.isNotEmpty) TableDescription(tableDescription: description),
                //
                //
              ],
            ),
          );
        }),
  );
}
