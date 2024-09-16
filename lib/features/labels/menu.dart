import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
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
    if (title.isNotEmpty) MenuItem(label: title),
    if (title.isNotEmpty) PopupMenuDivider(height: smallHeight()),
    //
    LabelManager(isPopup: true, isSelection: isSelection, alreadySelected: alreadySelected, onDone: onDone),
    //
  ];
}
