import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_variables/colors.dart';
import '../../../_widgets/buttons/buttons.dart';
import '../../../_widgets/others/text.dart';
import '../../_notes/items/picker_type.dart';

Map pins = {
  'PIN 1': '0',
  'PIN 2': '0',
  'PIN 3': '0',
  'PIN 4': '0',
  'PIN 5': '0',
  'PIN 6': '0',
};

Map states = {
  'HIGH': '0',
  'LOW': '0',
};

class PinStateBlock extends StatefulWidget {
  const PinStateBlock({super.key});

  @override
  State<PinStateBlock> createState() => _LedPinBlockState();
}

class _LedPinBlockState extends State<PinStateBlock> {
  String pin = 'PIN 1';
  String state = 'HIGH';

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: AppButton(
        color: backgroundColors['2']!.shadeColor,
        borderRadius: borderRadiusMediumSmall,
        child: Wrap(
          runSpacing: smallWidth(),
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            //
            AppText(text: 'turn pin', color: black),
            //
            spw(),
            //
            AppTypePicker(
              initial: pin,
              typeEntries: pins,
              onSelect: (chosenType, chosenValue) => setState(() => pin = chosenType),
              bgColor: white,
              textColor: black,
              borderRadius: borderRadiusSmall,
            ),
            //
            spw(),
            //
            AppTypePicker(
              initial: state,
              typeEntries: states,
              onSelect: (chosenType, chosenValue) => setState(() => state = chosenType),
              bgColor: white,
              textColor: black,
              borderRadius: borderRadiusSmall,
            ),
            //
          ],
        ),
      ),
    );
  }
}
