import 'package:flutter/material.dart';

import '../../_widgets/menu/menu_item.dart';
import 'manager.dart';

List<Widget> labelsMenu({
  String title = '',
  List alreadySelected = const [],
  Function(List newLabels)? onDone,
  bool isSelection = false,
}) {
  return [
    //
    MenuItem(label: title, smallHeight: true, popTrailing: true),
    menuDivider(),
    //
    LabelManager(isPopup: true, isSelection: isSelection, alreadySelected: alreadySelected, onDone: onDone),
    //
  ];
}
