import 'package:flutter/material.dart';

import '../../__styling/variables.dart';
import '../../_providers/providers.dart';
import '../../_widgets/buttons/buttons.dart';
import '../../_widgets/menu/menu_item.dart';
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
      menuItems: fileOptions(fileId, fileName),
      isSquare: true,
      leading: moreIcon,
      noStyling: !isImageFile(fileName),
    );
  }
}

List<Widget> fileOptions(String fileId, String fileName) {
  return [
    //
    if (!state.views.isChat())
      MenuItem(
        onTap: () => state.input.update(action: 'add', key: 'w', value: fileId),
        label: 'Make Cover',
        leading: Icons.push_pin_outlined,
      ),
    //
    MenuItem(
      onTap: () async => await downloadFile(fileId: fileId, fileName: fileName),
      label: 'Download ${isImageFile(fileName) ? 'Image' : 'File'}',
      leading: Icons.download_rounded,
    ),
    //
    MenuItem(
      onTap: () => state.input.update(action: 'remove', key: fileId),
      label: 'Remove ${isImageFile(fileName) ? 'Image' : 'File'}',
      leading: Icons.delete_rounded,
    ),
    //
  ];
}
