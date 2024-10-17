import 'package:flutter/material.dart';

import '../../_models/item.dart';
import '../../_widgets/menu/menu_item.dart';
import 'manager.dart';

List<Widget> tagsMenu({
  String title = '',
  Item? item,
  required Function(String) onUpdate,
  bool isSelection = false,
}) {
  return [
    //
    MenuItem(label: title, smallHeight: true, popTrailing: true),
    menuDivider(),
    TagManager(item: item, isPopup: true, isSelection: isSelection, onUpdate: onUpdate),
    //
  ];
}
