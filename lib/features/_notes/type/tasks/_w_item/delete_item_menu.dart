import 'package:flutter/material.dart';

import '../../../../../_helpers/_common/navigation.dart';
import '../../../../../_variables/features.dart';
import '../../../../../_widgets/buttons/button.dart';
import '../../../../../_widgets/menu/confirmation.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../files/_helpers/helper.dart';
import '../../../_helpers/delete_item.dart';

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
      tooltip: 'Delete task item',
      menuItems: confirmationMenu(
        title: 'Delete task item?',
        onConfirm: () {
          deleteItemForever(type: feature.items.t, itemId: listId, subId: itemId, files: getFiles(itemData));
          popWhatsOnTop(); // close popup menu
          popWhatsOnTop(); // close dialog
        },
      ),
      isSquare: true,
      dryWidth: true,
      child: AppIcon(Icons.delete_rounded, bgColor: bgColor, faded: true, size: 16),
    );
  }
}
