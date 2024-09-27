import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_providers/input.dart';
import '../../../../_variables/features.dart';
import '../../../_notes/_w/picker_type.dart';
import '../../_vars/variables.dart';

class TypePicker extends StatelessWidget {
  const TypePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      return AppTypePicker(
        type: feature.calendar,
        subType: 'y',
        initial: input.item.data['y'],
        typeEntries: sessionsTypes,
        onSelect: (chosenType, chosenValue) => input.update('y', chosenType),
        // bgColor: transparent,
      );
    });
  }
}
