import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_helpers/items/delete_item.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/abcs/dialogs_sheets/dialog_buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../files/_helpers/helper.dart';

class DeleteItem extends StatelessWidget {
  const DeleteItem({
    super.key,
    required this.bgColor,
    required this.listId,
    required this.itemId,
    required this.itemData,
  });

  final String bgColor;
  final String listId;
  final String itemId;
  final Map itemData;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      tooltip: 'Delete Item',
      menuItems: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            Flexible(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: AppText(text: 'Delete item?'),
            )),
            //
            lph(),
            //
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ActionButton(
                  isCancel: true,
                ),
                ActionButton(
                  label: 'Delete',
                  onPressed: () {
                    deleteItemForever(type: feature.lists.t, itemId: listId, subId: itemId, files: getFiles(itemData));
                    popWhatsOnTop(); // close popup menu
                    popWhatsOnTop(); // close dialog
                  },
                ),
              ],
            ),
          ],
        ),
      ],
      child: AppIcon(Icons.delete_rounded, bgColor: bgColor, faded: true, size: 16),
    );
  }
}
