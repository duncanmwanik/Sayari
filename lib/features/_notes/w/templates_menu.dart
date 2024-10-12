import 'package:flutter/material.dart';

import '../../../_variables/features.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../_helpers/prepare.dart';

List<Widget> templatesMenu() {
  return [
    //
    MenuItem(label: 'Chat', leading: Icons.hourglass_full, onTap: () => createNote(feature.chat)),
    MenuItem(label: 'Habit', leading: Icons.hourglass_full, onTap: () => createNote(feature.habits)),
    MenuItem(label: 'Finance', leading: Icons.attach_money, onTap: () => createNote(feature.finances)),
    MenuItem(label: 'Links', leading: Icons.link_sharp, onTap: () => createNote(feature.links)),
    MenuItem(label: 'Booking', leading: Icons.calendar_month, onTap: () => createNote(feature.bookings)),
    MenuItem(label: 'Portfolio', leading: Icons.workspace_premium, onTap: () => createNote(feature.portfolios)),
    //
  ];
}
