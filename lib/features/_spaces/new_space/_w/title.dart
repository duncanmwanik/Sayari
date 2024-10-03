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
      return Padding(
        padding: EdgeInsets.only(left: 30),
        child: DataInput(
          inputKey: 't',
          hintText: 'Workspace Title',
          autofocus: isNewSpace,
          fontSize: normal,
          weight: FontWeight.bold,
          keyboardType: TextInputType.name,
          filled: false,
        ),
      );
    });
  }
}
