import 'package:flutter/material.dart';

import '../../_widgets/menu/menu_item.dart';
import 'manager.dart';

List<Widget> tagsMenu({
  String title = '',
  List alreadySelected = const [],
  Function(List newTags)? onDone,
  bool isSelection = false,
}) {
  return [
    //
    MenuItem(label: title, smallHeight: true, popTrailing: true),
    menuDivider(),
    //
    TagManager(isPopup: true, isSelection: isSelection, alreadySelected: alreadySelected, onDone: onDone),
    //
  ];
}
