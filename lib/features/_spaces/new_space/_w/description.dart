import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_providers/input.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_widgets/forms/input.dart';
import '../../../../_widgets/others/icons.dart';

class Description extends StatelessWidget {
  const Description({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Padding(
            padding: EdgeInsets.only(top: 12),
            child: AppIcon(
              Icons.subject_rounded,
              faded: true,
              size: 18,
            ),
          ),
          //
          spw(),
          //
          Expanded(
            child: DataInput(inputKey: 'n', hintText: 'Add Description'),
          ),
          //
        ],
      );
    });
  }
}
