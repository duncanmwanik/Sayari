import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_variables/colors.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/forms/numeric.dart';
import '../../../_widgets/others/text.dart';

class DelayBlock extends StatefulWidget {
  const DelayBlock({super.key});

  @override
  State<DelayBlock> createState() => _DelayBlockState();
}

class _DelayBlockState extends State<DelayBlock> {
  @override
  Widget build(BuildContext context) {
    return AppButton(
      color: backgroundColors['0']!.shadeColor,
      borderRadius: borderRadiusMediumSmall,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          AppText(text: 'delay', color: black),
          //
          spw(),
          //
          NumericFormInput(
            onChanged: (value) {
              if (value.isNotEmpty) {}
            },
            initialValue: '1000',
            hintText: 'ms',
            bgColor: white,
            textColor: black,
            borderRadius: borderRadiusSmall,
          ),
          //
          spw(),
          //
          AppText(text: 'milliseconds', color: black),
          //
        ],
      ),
    );
  }
}
