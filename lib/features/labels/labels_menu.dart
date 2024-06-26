import 'package:flutter/material.dart';

import 'label_manager.dart';

List<Widget> labelsMenu({List alreadySelected = const [], Function(List newLabels)? onDone, bool isSelection = false}) {
  return [
    LabelManager(isPopup: true, isSelection: isSelection, alreadySelected: alreadySelected, onDone: onDone),
  ];
}
