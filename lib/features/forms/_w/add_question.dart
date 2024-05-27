import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/helpers.dart';

class AddForm extends StatelessWidget {
  const AddForm({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onPressed: () => addForm(),
      borderRadius: borderRadiusSmall,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppIcon(Icons.add, faded: true),
          spw(),
          Flexible(child: AppText(text: 'Add Question', faded: true)),
        ],
      ),
    );
  }
}
