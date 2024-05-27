import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_variables/colors.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/forms/numeric.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';

class DelayBlock extends StatefulWidget {
  const DelayBlock({super.key});

  @override
  State<DelayBlock> createState() => _DelayBlockState();
}

class _DelayBlockState extends State<DelayBlock> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        AppButton(
          onPressed: () {},
          color: backgroundColors['0']!.shadeColor,
          borderRadius: borderRadiusMediumSmall,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              AppText(size: normal, text: 'delay', color: black),
              //
              spw(),
              //
              NumericFormInput(
                onChanged: (value) {
                  if (value.isNotEmpty) {}
                },
                initialValue: '3',
                maxLength: 3,
                hintText: 'Sec',
                bgColor: white,
                textColor: black,
                borderRadius: borderRadiusSmall,
              ),
              //
              spw(),
              //
              AppText(size: normal, text: 'seconds', color: black),
              //
            ],
          ),
        ),
        //
        spw(),
        //
        AppIcon(Icons.drag_indicator, size: 16, faded: true),
        //
      ],
    );
  }
}
