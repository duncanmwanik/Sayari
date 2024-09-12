import 'package:flutter/material.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/text.dart';
import '../_helpers/helpers.dart';

class AddLink extends StatelessWidget {
  const AddLink({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onPressed: () => addLink(),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppIcon(Icons.add, faded: true),
          spw(),
          Flexible(child: AppText(text: 'Add Link', faded: true)),
        ],
      ),
    );
  }
}
