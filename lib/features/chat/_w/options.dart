import 'package:flutter/material.dart';

import '../../../_widgets/abcs/menu/menu_item.dart';
import '../_helpers/delete_message.dart';

List<Widget> messageMenu(String messageId, Map messageData) {
  return [
    //
    MenuItem(
      onTap: () {},
      label: 'Edit',
      iconData: Icons.edit_rounded,
    ),
    //
    MenuItem(
      onTap: () {},
      label: 'Copy Text',
      iconData: Icons.download_rounded,
    ),
    //
    MenuItem(
      onTap: () {},
      label: 'Pin',
      iconData: Icons.push_pin_outlined,
    ),
    //
    MenuItem(
      onTap: () => deleteMessageForUser(messageId),
      label: 'Delete',
      iconData: Icons.delete_rounded,
    ),
    //
  ];
}
