import 'package:flutter/material.dart';

import '../../../_models/item.dart';
import '../../../_variables/colors.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/text.dart';

class SessionType extends StatelessWidget {
  const SessionType({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // session type
        AppButton(
          color: backgroundColors[item.color()]!.color,
          smallVerticalPadding: true,
          child: AppText(
            text: item.sessionType(),
            weight: FontWeight.bold,
            color: backgroundColors[item.color()]!.textColor,
          ),
        ),
        //
      ],
    );
  }
}
