import 'package:flutter/material.dart';

import '../../../__styling/variables.dart';
import '../../../_variables/colors.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/text.dart';

class SessionType extends StatelessWidget {
  const SessionType({super.key, required this.sessionsType, required this.sessionColor});

  final String sessionsType;
  final String sessionColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Session Type
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: backgroundColors[sessionColor]!.color,
            borderRadius: BorderRadius.circular(borderRadiusSmall),
          ),
          child: AppText(
            text: sessionsType,
            fontWeight: FontWeight.w700,
            color: backgroundColors[sessionColor]!.textColor,
          ),
        ),
        //
        AppCloseButton(faded: true),
        //
      ],
    );
  }
}
