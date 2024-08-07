import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/variables.dart';
import '../../_providers/common/input.dart';
import '../../_variables/features.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/others/checkbox.dart';
import '../../_widgets/others/text.dart';
import '../_notes/_helpers/quick_edit.dart';

class CodeRepeat extends StatelessWidget {
  const CodeRepeat({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      bool repeatOn = input.data['r'] == '1' || input.data['r'] == null;

      return AppButton(
        onPressed: () {
          input.update(action: 'add', key: 'r', value: repeatOn ? '0' : '1');
          editItemExtras(type: feature.code.t, itemId: input.itemId, key: 'r', value: repeatOn ? '0' : '1');
        },
        noStyling: true,
        smallVerticalPadding: true,
        smallRightPadding: true,
        borderRadius: borderRadiusLarge,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppCheckBox(isChecked: repeatOn),
            AppText(size: small, text: 'Repeat', faded: true),
          ],
        ),
      );
    });
  }
}
