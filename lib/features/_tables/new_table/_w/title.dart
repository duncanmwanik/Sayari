import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../__styling/variables.dart';
import '../../../../_providers/common/input.dart';
import '../../../../_widgets/others/forms/input.dart';

class TitleInput extends StatelessWidget {
  const TitleInput({super.key, required this.isNewTable});

  final bool isNewTable;

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      return Padding(
        padding: const EdgeInsets.only(left: 30),
        child: DataInput(
          inputKey: 't',
          hintText: 'Table Name',
          autofocus: isNewTable,
          fontSize: large,
          fontWeight: FontWeight.w700,
          keyboardType: TextInputType.name,
          filled: false,
        ),
      );
    });
  }
}
