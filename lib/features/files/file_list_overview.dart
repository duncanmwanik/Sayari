import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_models/item.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';

class FileListOverview extends StatelessWidget {
  const FileListOverview({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingM('t'),
      child: AppButton(
        smallVerticalPadding: true,
        smallLeftPadding: true,
        smallRightPadding: true,
        color: item.hasColor() ? Colors.white24 : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppIcon(Icons.folder_open_rounded, size: medium, faded: true),
            tpw(),
            AppText(text: '${item.files().length}', size: tiny, faded: true),
          ],
        ),
      ),
    );
  }
}
