import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/clipboard.dart';
import '../../../_models/item.dart';
import '../../../_providers/hover.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../../../_widgets/others/icons.dart';
import '../../_spaces/_helpers/checks_space.dart';
import '../_helpers/delete.dart';
import '../_helpers/helpers.dart';

class MessageActions extends StatelessWidget {
  const MessageActions({super.key, required this.item, this.isSent = false});

  final Item item;
  final bool isSent;

  @override
  Widget build(BuildContext context) {
    return Consumer<HoverProvider>(
      builder: (context, hover, child) => Visibility(
        visible: hover.id == item.sid,
        child: Padding(
          padding: paddingC('t5'),
          child: AppButton(
            menuItems: [
              //
              // if (isAdmin())
              // MenuItem(
              //   onTap: () {},
              //   label: 'Edit',
              //   leading: Icons.edit_rounded,
              // ),
              //
              MenuItem(
                onTap: () => copyText(item.data['n'], toast: false),
                label: 'Copy Text',
                leading: Icons.copy_rounded,
              ),
              //
              if (isAdmin())
                MenuItem(
                  onTap: () => item.isPinned() ? unPinMessage(item) : pinMessage(item),
                  label: item.isPinned() ? 'Unpin' : 'Pin',
                  leading: item.isPinned() ? Icons.push_pin : Icons.push_pin_outlined,
                ),
              //
              // if (isAdmin())
              //   MenuItem(
              //     onTap: () {},
              //     label: item.isPinned() ? 'Unstar' : 'Star',
              //     leading: item.isPinned() ? Icons.star : Icons.star_outline,
              //   ),
              //
              menuDivider(),
              //
              if (isAdmin())
                MenuItem(
                  onTap: () => deleteMessage(item),
                  label: 'Delete For Me',
                  leading: Icons.delete_rounded,
                ),
              if (isAdmin())
                MenuItem(
                  onTap: () => deleteMessage(item, forAll: true),
                  label: 'Delete For All',
                  leading: Icons.delete_rounded,
                ),
              //
            ],
            isRound: true,
            child: AppIcon(Icons.more_horiz, size: normal),
          ),
        ),
      ),
    );
  }
}
