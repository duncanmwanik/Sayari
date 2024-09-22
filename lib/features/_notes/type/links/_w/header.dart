import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_providers/_providers.dart';
import '../../../../../_providers/input.dart';
import '../../../../../_variables/features.dart';
import '../../../../../_widgets/buttons/button.dart';
import '../../../../../_widgets/menu/menu_item.dart';
import '../../../../../_widgets/others/checkbox.dart';
import '../../../../../_widgets/others/text.dart';
import '../../../../files/_helpers/upload.dart';
import '../../../../files/image.dart';
import '../../../../files/viewer.dart';
import '../../bookings/_w/copy_link.dart';
import 'username.dart';

class LinkHeader extends StatelessWidget {
  const LinkHeader({super.key});

  @override
  Widget build(BuildContext context) {
    String fileId = state.input.data['cv'] ?? '';
    String fileName = state.input.data[fileId] ?? '';
    bool hasImage = fileId.isNotEmpty;

    return AppButton(
      borderRadius: borderRadiusMediumSmall,
      color: transparent,
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          AppButton(
            onPressed: hasImage
                ? null
                : () async {
                    await getFilesToUpload(
                      multiple: false,
                      imagesOnly: true,
                      embed: true,
                      onDone: (stash) {
                        state.input.remove(fileId);
                        state.input.addAll({'cv': stash.fileId()});
                      },
                    );
                  },
            menuItems: hasImage
                ? [
                    MenuItem(
                      label: 'Edit Image',
                      leading: Icons.edit,
                      onTap: () async {
                        await getFilesToUpload(
                          multiple: false,
                          imagesOnly: true,
                          embed: true,
                          onDone: (stash) {
                            state.input.remove(fileId);
                            state.input.addAll({'cv': stash.fileId()});
                          },
                        );
                      },
                    ),
                    if (fileId.isNotEmpty)
                      MenuItem(
                        label: 'View Image',
                        leading: Icons.image,
                        onTap: () => showImageViewer(images: {fileId: fileName}),
                      ),
                    if (fileId.isNotEmpty)
                      MenuItem(
                        label: 'Remove Image',
                        leading: Icons.close,
                        onTap: () async {
                          state.input.remove(fileId);
                          state.input.addAll({'cv': ''});
                        },
                      ),
                  ]
                : null,
            padding: EdgeInsets.all(3),
            borderRadius: borderRadiusCrazy,
            child: ImageFile(
              fileId,
              fileName,
              images: {fileId: fileName},
              ignore: true,
              showOptions: false,
              radius: borderRadiusCrazy,
              size: 80,
            ),
          ),
          //
          mph(),
          //
          LinkUserName(),
          //
          mph(),
          // active button
          Consumer<InputProvider>(builder: (context, input, child) {
            bool isActive = input.data[feature.share] == '1';

            return Wrap(
              spacing: smallWidth(),
              runSpacing: smallWidth(),
              children: [
                //
                AppButton(
                  onPressed: () => input.update(feature.share, isActive ? '0' : '1'),
                  smallRightPadding: true,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(text: 'Active'),
                      spw(),
                      AppCheckBox(isChecked: isActive, smallPadding: true),
                    ],
                  ),
                ),
                //
                CopyLink(path: input.item.sharedLink(), isMinimized: true),
                //
              ],
            );
          }),
          //
        ],
      ),
    );
  }
}
