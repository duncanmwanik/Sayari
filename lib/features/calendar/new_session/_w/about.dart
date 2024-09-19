import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../__styling/spacing.dart';
import '../../../../_providers/input.dart';
import '../../../../_widgets/others/forms/input.dart';
import '../../../../_widgets/others/icons.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(
        builder: (context, input, child) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: AppIcon(Icons.subject_rounded, faded: true, size: 18),
                ),
                //
                spw(),
                //
                Expanded(
                  child: DataInput(inputKey: 'a', hintText: 'Short Description', textCapitalization: TextCapitalization.sentences),
                ),
                //
              ],
            ));
  }
}
