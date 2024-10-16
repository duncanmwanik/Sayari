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
import '../../../_widgets/menu/confirmation.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../../../_widgets/others/checkbox.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../_notes/types/bookings/_w/copy_link.dart';
import '../../files/_helpers/upload.dart';
import '../../files/image.dart';
import '../../files/viewer.dart';
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
                    srp: true,
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
                      onAccept: () => input.remove(feature.share),
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
              mph(),
              // cover image
              AppButton(
                menuItems: [
                  MenuItem(
                      leading: Icons.edit,
                      label: 'Edit Cover',
                      onTap: () async => await getFilesToUpload(
                            allowMultiple: false,
                            imagesOnly: true,
                            onDone: (stash) {
                              input.remove(fileId);
                              input.addAll({'w': stash.fileId()});
                            },
                          )),
                  MenuItem(leading: Icons.image, label: 'View Cover', onTap: () => showImageViewer(images: {fileId: fileName})),
                  MenuItem(
                      leading: Icons.delete_outline,
                      label: 'Remove Cover',
                      menuItems: confirmationMenu(
                        title: 'Remove cover?',
                        yeslabel: 'Remove',
                        onConfirm: () {
                          input.removeMatch('fl');
                          input.remove('w');
                        },
                      ))
                ],
                noStyling: true,
                padding: noPadding,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    SizedBox(
                      height: (isTabAndBelow() ? 15.h : 20.h) / 0.7092,
                      width: (isTabAndBelow() ? 15.h : 20.h),
                      child: ImageFile(
                        fileId,
                        fileName,
                        images: {fileId: fileName},
                        fit: BoxFit.fitHeight,
                        showOptions: false,
                        ignore: true,
                      ),
                    ),
                    AppIcon(Icons.edit, faded: true)
                  ],
                ),
              ),
              //
            ],
          ),
        ),
      );
    });
  }
}
