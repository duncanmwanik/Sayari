import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_helpers/_common/global.dart';
import '../../../../_providers/common/input.dart';
import '../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../_widgets/abcs/dialogs_sheets/confirmation_dialog.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/others/divider.dart';
import '../../../../_widgets/others/text.dart';
import '../../../files/_helpers/upload.dart';
import '../../../files/image.dart';

class PublishedSpace extends StatefulWidget {
  const PublishedSpace({super.key, this.showIcon = true});

  final bool showIcon;

  @override
  State<PublishedSpace> createState() => _PublishSpaceState();
}

class _PublishSpaceState extends State<PublishedSpace> {
  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      bool isPublished = input.data['sp'] == '1';
      String fileId = input.data['sf'] ?? '';
      String fileName = input.data[fileId] ?? '';
      printThis(input.data);

      return Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            Row(
              children: [
                //
                AppButton(
                  smallRightPadding: isPublished,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppIcon(FontAwesomeIcons.bookOpen, size: 12),
                      pw(10),
                      Flexible(child: AppText(text: 'Published as Book')),
                      if (isPublished) spw(),
                      if (isPublished) AppIcon(Icons.check_circle_rounded, color: styler.accent),
                    ],
                  ),
                ),
                //
                if (isPublished) spw(),
                if (isPublished)
                  AppButton(
                    onPressed: () => showConfirmationDialog(
                      title: 'Unpublish as book?',
                      yeslabel: 'Unpublish',
                      onAccept: () => input.update(action: 'add', key: 'sp', value: '0'),
                    ),
                    noStyling: true,
                    showBorder: true,
                    child: AppText(text: 'Unpublish'),
                  ),
                //
              ],
            ),
            //
            if (isPublished)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //
                  sph(),
                  //
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //
                      AppButton(
                        onPressed: () async {
                          await getFilesToUpload(allowMultiple: false, imagesOnly: true).then((fileMap) {
                            if (fileMap.isNotEmpty) {
                              String newFileId = 'f${getUniqueId()}';
                              input.update(action: 'rem', key: fileId);
                              input.addAll({newFileId: fileMap.keys.first, 'sf': newFileId});
                            }
                          });
                        },
                        noStyling: true,
                        showBorder: true,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppText(text: '${fileId.isEmpty ? 'Add' : 'Change'} Book Cover', size: small, faded: true),
                            spw(),
                            AppIcon(Icons.edit, size: small),
                          ],
                        ),
                      ),
                      //
                      spw(),
                      //
                      AppButton(
                        onPressed: () {
                          input.update(action: 'rem', key: 'sf');
                          input.update(action: 'rem', key: fileId);
                          // input.update(action: 'rem', key: 'f1722442156227');
                        },
                        noStyling: true,
                        showBorder: true,
                        isSquare: true,
                        child: AppIcon(Icons.delete, size: medium, faded: true),
                      ),
                      //
                    ],
                  ),
                  //
                  mph(),
                  //
                  ImageFile(
                    fileId,
                    fileName,
                    {fileId: fileName},
                    radius: borderRadiusTiny,
                    size: 20.h,
                    showOptions: false,
                  ),
                  //
                  // cost
                  //
                ],
              ),
            //
            if (isPublished) AppDivider(),
            //
          ],
        ),
      );
    });
  }
}
