import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/global.dart';
import '../../../_providers/common/input.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/buttons.dart';
import '../../../_widgets/dialogs/confirmation_dialog.dart';
import '../../../_widgets/others/checkbox.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/others/divider.dart';
import '../../../_widgets/others/text.dart';
import '../../_notes/type/bookings/_w/copy_link.dart';
import '../../files/_helpers/upload.dart';
import '../../files/image.dart';
import '../../share/_helpers/share.dart';
import '../_helpers/common.dart';

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
      bool isPublished = input.data[feature.share.lt] == '1';
      String fileId = input.data['w'] ?? '';
      String fileName = input.data[fileId] ?? '';
      printThis(input.data);

      return Visibility(
        visible: isPublished,
        child: Padding(
          padding: EdgeInsets.only(left: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              Wrap(
                spacing: smallWidth(),
                runSpacing: smallWidth(),
                children: [
                  //
                  AppButton(
                    onPressed: () => input.update(feature.share.lt, isPublished ? '0' : '1'),
                    smallRightPadding: true,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppText(text: 'Active'),
                        spw(),
                        AppCheckBox(isChecked: isPublished, smallPadding: true),
                      ],
                    ),
                  ),
                  //
                  AppButton(
                    onPressed: () => showConfirmationDialog(
                      title: 'Unpublish as book?',
                      yeslabel: 'Unpublish',
                      onAccept: () {
                        input.remove(feature.share.lt);
                        shareItem(delete: true, itemId: liveSpace());
                      },
                    ),
                    noStyling: true,
                    showBorder: true,
                    child: AppText(text: 'Unpublish'),
                  ),
                  //
                  CopyLink(
                    path: '/${features[feature.space.lt]!.path}/${liveSpace()}',
                    isMinimized: true,
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
                images: {fileId: fileName},
                height: (isTabAndBelow() ? 15.h : 20.h) / 0.7092,
                // width: isTabAndBelow() ? 15.h : 20.h,
                fit: BoxFit.fitHeight,
                showOptions: false,
              ),
              //
              mph(),
              Wrap(
                spacing: smallWidth(),
                runSpacing: smallWidth(),
                children: [
                  //
                  AppButton(
                    onPressed: () async {
                      await getFilesToUpload(
                        multiple: false,
                        imagesOnly: true,
                        onDone: (stash) {
                          input.remove(fileId);
                          input.addAll({'w': stash.fileId()});
                        },
                      );
                    },
                    noStyling: true,
                    showBorder: true,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppIcon(Icons.edit, size: small),
                        spw(),
                        AppText(text: 'Edit cover', size: small, faded: true),
                      ],
                    ),
                  ),
                  //
                  AppButton(
                    onPressed: () {
                      input.removeAll('f');
                      input.addAll({'w': ''});
                    },
                    noStyling: true,
                    showBorder: true,
                    child: AppText(text: 'Remove cover', size: small, faded: true),
                  ),
                  //
                ],
              ),
              //
              AppDivider(),
              //
            ],
          ),
        ),
      );
    });
  }
}
