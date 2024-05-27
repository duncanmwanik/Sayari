import 'package:flutter/material.dart';

import '../../_providers/providers.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/abcs/menu/menu_item.dart';
import '_helpers/download.dart';
import '_helpers/helper.dart';

class FileOptions extends StatelessWidget {
  const FileOptions(this.fileId, this.fileName, {super.key});

  final String fileId;
  final String fileName;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      tooltip: 'Options',
      menuItems: [
        //
        if (!state.views.isChat())
          MenuItem(
            onTap: () => state.input.update(action: 'add', key: 'w', value: fileId),
            label: 'Make Overview',
            iconData: Icons.image_rounded,
          ),
        //
        MenuItem(
          onTap: () async => await downloadFile(fileId: fileId, fileName: fileName),
          label: 'Download ${isImageFile(fileName) ? 'Image' : 'File'}',
          iconData: Icons.download_rounded,
        ),
        //
        MenuItem(
          onTap: () => state.input.update(action: 'remove', key: fileId),
          label: 'Remove ${isImageFile(fileName) ? 'Image' : 'File'}',
          iconData: Icons.delete_rounded,
        ),
        //
      ],
      leading: Icons.more_vert_rounded,
      noStyling: !isImageFile(fileName),
    );
  }
}
