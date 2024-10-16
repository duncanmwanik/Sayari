import 'package:flutter/material.dart';

import '../../../_helpers/navigation.dart';
import '../../../_models/item.dart';
import '../../../_theme/spacing.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/menu/confirmation.dart';
import '../../../_widgets/others/icons.dart';
import '../_helpers/copy.dart';
import '../_helpers/delete.dart';
import '../_helpers/prepare.dart';

class SessionOptions extends StatelessWidget {
  const SessionOptions({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: smallWidth(),
      runSpacing: smallWidth(),
      alignment: WrapAlignment.end,
      children: [
        //
        AppButton(
          onPressed: () {
            popWhatsOnTop();
            editSession(item);
          },
          tooltip: 'Edit Session',
          noStyling: true,
          isSquare: true,
          child: AppIcon(Icons.edit_rounded, faded: true, size: 18),
        ),
        //
        AppButton(
          onPressed: () => copySessionToDates(item: item, move: false),
          tooltip: 'Copy to Date',
          noStyling: true,
          isSquare: true,
          child: AppIcon(Icons.copy_rounded, faded: true, size: 18),
        ),
        //
        AppButton(
          onPressed: () => copySessionToDates(item: item, move: true),
          tooltip: 'Move To Date',
          noStyling: true,
          isSquare: true,
          child: AppIcon(Icons.forward_rounded, faded: true, size: 18),
        ),
        //
        AppButton(
          menuItems: confirmationMenu(
            title: 'Delete session?',
            onConfirm: () => deleteSession(item: item),
          ),
          tooltip: 'Delete Session',
          noStyling: true,
          isSquare: true,
          child: AppIcon(Icons.delete_forever_rounded, faded: true, size: 18),
        ),
        //
      ],
    );
  }
}
