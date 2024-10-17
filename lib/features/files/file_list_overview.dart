import 'package:flutter/material.dart';

import '../../_models/item.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';

class FileListOverview extends StatelessWidget {
  const FileListOverview({super.key, required this.sitem, required this.item});

  final Item item;
  final Item sitem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padM('t'),
      child: AppButton(
        svp: true,
        slp: true,
        srp: true,
        noStyling: true,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppIcon(Icons.folder_open_rounded, size: medium, faded: true, bgColor: item.color()),
            tpw(),
            AppText(text: '${sitem.files().length}', size: tiny, faded: true, bgColor: item.color()),
          ],
        ),
      ),
    );
  }
}
