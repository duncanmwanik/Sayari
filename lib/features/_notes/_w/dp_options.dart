import 'package:flutter/material.dart';

import '../../../_variables/features.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../_helpers/prepare.dart';

List<Widget> templatesMenu() {
  return [
    //
    MenuItem(label: 'Habit', leading: Icons.hourglass_full, onTap: () => prepareNoteForCreation(feature.habits)),
    MenuItem(label: 'Finance', leading: Icons.attach_money, onTap: () => prepareNoteForCreation(feature.finances)),
    MenuItem(label: 'Links', leading: Icons.link_sharp, onTap: () => prepareNoteForCreation(feature.links)),
    MenuItem(label: 'Booking', leading: Icons.calendar_month, onTap: () => prepareNoteForCreation(feature.bookings)),
    MenuItem(label: 'Portfolio', leading: Icons.workspace_premium, onTap: () => prepareNoteForCreation(feature.portfolios)),
    //
  ];
}
