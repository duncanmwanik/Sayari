import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../__styling/variables.dart';
import '../../../../_providers/input.dart';
import '../../../../_widgets/forms/input.dart';

class TitleInput extends StatelessWidget {
  const TitleInput(this.isNewSpace, {super.key});

  final bool isNewSpace;

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      return DataInput(
        inputKey: 't',
        hintText: 'Space Title',
        autofocus: isNewSpace,
        fontSize: normal,
        weight: FontWeight.bold,
        keyboardType: TextInputType.name,
        filled: false,
      );
    });
  }
}
