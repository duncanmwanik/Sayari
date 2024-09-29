import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/input.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/dialogs/confirmation_dialog.dart';
import '../../../_widgets/others/checkbox.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/others/divider.dart';
import '../../../_widgets/others/text.dart';
import '../../_notes/bookings/_w/copy_link.dart';
import '../../files/_helpers/upload.dart';
import '../../files/image.dart';
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
      bool isPublished = input.item.data[feature.share] == '1';
      String fileId = input.item.data['w'] ?? '';
      String fileName = input.item.data[fileId] ?? '';

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
                    onPressed: () => input.update(feature.share, isPublished ? '0' : '1'),
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
                        input.remove(feature.share);
                      },
                    ),
                    noStyling: true,
                    showBorder: true,
                    child: AppText(text: 'Unpublish'),
                  ),
                  //
                  CopyLink(path: publishedSpaceLink(true), isMinimized: true),
                  //
                ],
              ),
              //
              mph(),
              ImageFile(
                fileId,
                fileName,
                images: {fileId: fileName},
                height: (isTabAndBelow() ? 15.h : 20.h) / 0.7092,
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
                        allowMultiple: false,
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
                      input.removeMatch('fl');
                      input.remove('w');
                    },
                    noStyling: true,
                    showBorder: true,
                    child: AppText(text: 'Remove cover', size: small, faded: true),
                  ),
                  //
                ],
              ),
              //
              AppDivider(height: mediumHeight()),
              //
            ],
          ),
        ),
      );
    });
  }
}
