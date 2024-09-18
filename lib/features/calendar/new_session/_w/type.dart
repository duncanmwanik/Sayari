import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../__styling/variables.dart';
import '../../../../_providers/common/input.dart';
import '../../../../_variables/features.dart';
import '../../../_notes/items/picker_type.dart';
import '../../_vars/variables.dart';

class TypePicker extends StatelessWidget {
  const TypePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      return AppTypePicker(
        type: feature.calendar.t,
        subType: 'y',
        initial: input.data['y'],
        typeEntries: sessionsTypes,
        onSelect: (chosenType, chosenValue) => input.update('y', chosenType),
        bgColor: transparent,
      );
    });
  }
}
