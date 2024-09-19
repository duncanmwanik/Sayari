import 'package:flutter/material.dart';

import '../../../_helpers/_common/clipboard.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../../_spaces/_helpers/checks_space.dart';
import '../_helpers/helpers.dart';

List<Widget> messageMenu(String id, Map data) {
  bool isPinned = data['p'] == '1';

  return [
    //
    // if (isAdmin())
    // MenuItem(
    //   onTap: () {},
    //   label: 'Edit',
    //   leading: Icons.edit_rounded,
    // ),
    //
    MenuItem(
      onTap: () => copyToClipboard(data['n'], toast: false),
      label: 'Copy Text',
      leading: Icons.copy_rounded,
    ),
    //
    if (isAdmin())
      MenuItem(
        onTap: () => isPinned ? unPinMessage(id) : pinMessage(id),
        label: isPinned ? 'Unpin' : 'Pin',
        leading: isPinned ? Icons.push_pin : Icons.push_pin_outlined,
      ),
    //
    if (isAdmin())
      MenuItem(
        onTap: () => deleteMessageForUser(id),
        label: 'Delete',
        leading: Icons.delete_rounded,
      ),
    //
  ];
}
