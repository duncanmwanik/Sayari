import 'package:flutter/material.dart';

import '../../../_widgets/abcs/menu/menu_item.dart';

List<Widget> graphMenu() {
  return [
    MenuItem(iconData: Icons.share_rounded, label: 'Save as image', onTap: () {}),
    MenuItem(iconData: Icons.share_rounded, label: 'Save as PDF', onTap: () {}),
  ];
}
