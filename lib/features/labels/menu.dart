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
    if (title.isNotEmpty) MenuItem(label: title),
    if (title.isNotEmpty) menuDivider(),
    //
    LabelManager(isPopup: true, isSelection: isSelection, alreadySelected: alreadySelected, onDone: onDone),
    //
  ];
}
