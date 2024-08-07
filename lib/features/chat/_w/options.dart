import 'package:flutter/material.dart';

import '../../../_widgets/abcs/menu/menu_item.dart';
import '../_helpers/delete_message.dart';

List<Widget> messageMenu(String messageId, Map messageData) {
  return [
    //
    MenuItem(
      onTap: () {},
      label: 'Edit',
      leading: Icons.edit_rounded,
    ),
    //
    MenuItem(
      onTap: () {},
      label: 'Copy Text',
      leading: Icons.copy_rounded,
    ),
    //
    MenuItem(
      onTap: () {},
      label: 'Pin',
      leading: Icons.push_pin_outlined,
    ),
    //
    MenuItem(
      onTap: () => deleteMessageForUser(messageId),
      label: 'Delete',
      leading: Icons.delete_rounded,
    ),
    //
  ];
}
