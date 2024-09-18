import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_variables/colors.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/text.dart';
import '../../_notes/items/picker_type.dart';

Map ledPins = {
  'ALL': '0',
  'LED 0': '0',
  'LED 1': '0',
  'LED 2': '0',
  'LED 3': '0',
  'LED 4': '0',
  'LED 5': '0',
  'LED 6': '0',
  'LED 7': '0',
  'LED 8': '0',
};

Map ledColors = {
  'Red': '0',
  'Green': '0',
  'Blue': '0',
  'Orange': '0',
  'Purple': '0',
  'Yellow': '0',
  'Pink': '0',
  'Cyan': '0',
  'Amber': '0',
};

class LedColorBlock extends StatefulWidget {
  const LedColorBlock({super.key});

  @override
  State<LedColorBlock> createState() => _LedPinBlockState();
}

class _LedPinBlockState extends State<LedColorBlock> {
  String ledPin = 'LED 0';
  String ledColor = 'Red';

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: AppButton(
        color: backgroundColors['1']!.shadeColor,
        borderRadius: borderRadiusMediumSmall,
        child: Wrap(
          runSpacing: smallWidth(),
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            //
            AppText(text: 'turn led', color: black),
            //
            spw(),
            //
            AppTypePicker(
              initial: ledPin,
              typeEntries: ledPins,
              onSelect: (chosenType, chosenValue) => setState(() => ledPin = chosenType),
              bgColor: white,
              textColor: black,
              borderRadius: borderRadiusSmall,
            ),
            //
            spw(),
            //
            AppText(text: 'to color', color: black),
            //
            spw(),
            //
            AppTypePicker(
              initial: ledColor,
              typeEntries: ledColors,
              onSelect: (chosenType, chosenValue) => setState(() => ledColor = chosenType),
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
