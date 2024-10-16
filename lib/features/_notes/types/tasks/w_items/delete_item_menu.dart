import 'package:flutter/material.dart';

import '../../../../../_helpers/navigation.dart';
import '../../../../../_helpers/sync/delete_item.dart';
import '../../../../../_models/item.dart';
import '../../../../../_widgets/buttons/button.dart';
import '../../../../../_widgets/menu/confirmation.dart';
import '../../../../../_widgets/others/icons.dart';

class DeleteItem extends StatelessWidget {
  const DeleteItem({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      tooltip: 'Delete Item',
      menuItems: confirmationMenu(
        title: 'Delete Item?',
        onConfirm: () => popWhatsOnTop(todo: () => deleteItemForever(item)),
      ),
      isSquare: true,
      dryWidth: true,
      noStyling: true,
      child: AppIcon(Icons.delete_outline, faded: true, size: 16),
    );
  }
}
