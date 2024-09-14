import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_variables/colors.dart';
import '../../../_widgets/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../_notes/items/picker_type.dart';

Map items = {
  'BUTTON A': '0',
  'BUTTON B': '0',
  'BUTTON C': '0',
  'PIN 1': '0',
  'PIN 2': '0',
  'PIN 3': '0',
  'PIN 4': '0',
  'PIN 5': '0',
  'PIN 6': '0',
  'PERSON DETECTED': '0',
  'IS DARK': '0',
};

Map states = {
  'PRESSED': '0',
  'NOT PRESSED': '0',
  'TRUE': '0',
  'FALSE': '0',
  'HIGH': '0',
  'LOW': '0',
};

class IfBlock extends StatefulWidget {
  const IfBlock({super.key, this.isWhile = false, this.data});

  final bool isWhile;
  final String? data;

  @override
  State<IfBlock> createState() => _LedPinBlockState();
}

class _LedPinBlockState extends State<IfBlock> {
  String item = 'BUTTON A';
  String state = 'PRESSED';

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: AppButton(
        color: backgroundColors[widget.isWhile ? '4' : '3']!.shadeColor,
        borderRadius: borderRadiusMediumSmall,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            Wrap(
              runSpacing: smallWidth(),
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                //
                AppText(text: widget.isWhile ? 'while' : 'if', color: black),
                //
                spw(),
                //
                AppTypePicker(
                  initial: item,
                  typeEntries: items,
                  onSelect: (chosenType, chosenValue) => setState(() => item = chosenType),
                  bgColor: white,
                  textColor: black,
                  borderRadius: borderRadiusSmall,
                ),
                //
                spw(),
                //
                AppText(text: 'is', color: black),
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
            //
            if (widget.data != null) sph(),
            //
            if (widget.data != null)
              Container(
                padding: padding(),
                constraints: BoxConstraints(minHeight: 30, minWidth: 200),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(borderRadiusMediumSmall),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //
                    AppButton(
                      onPressed: () {},
                      borderRadius: borderRadiusLarge,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppIcon(Icons.add, size: 16, color: black),
                          tpw(),
                          AppText(text: 'Add Block ', color: black),
                        ],
                      ),
                    ),
                    //
                  ],
                ),
              )
            //
          ],
        ),
      ),
    );
  }
}
