import 'package:flutter/material.dart';

import '../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../_widgets/abcs/menu/menu_item.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../__styling/variables.dart';
import '../_helpers/create_file.dart';
import '../_helpers/delete_file.dart';
import 'dialog_create_code.dart';

class CodeFileOptions extends StatelessWidget {
  const CodeFileOptions({super.key, required this.codeId, required this.codeMap});

  final String codeId;
  final Map codeMap;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      tooltip: 'Options',
      menuItems: [
        //
        MenuItem(
          label: 'Edit Title',
          leading: Icons.edit,
          onTap: () => showCreateCodeFileDialog(codeId: codeId, title: codeMap['t']),
        ),
        //
        MenuItem(
          label: 'Create Copy',
          leading: Icons.copy,
          onTap: () => createCodeFile(codeMap: codeMap),
        ),
        //
        MenuItem(
          label: 'Delete Code File',
          leading: Icons.delete_rounded,
          onTap: () => deleteCodeFile(codeId),
        ),
        //
      ],
      noStyling: true,
      isSquare: true,
      child: AppIcon(moreIcon, faded: true, size: medium),
    );
  }
}
