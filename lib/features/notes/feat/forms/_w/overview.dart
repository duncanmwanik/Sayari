import 'package:flutter/material.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_models/item.dart';
import '../../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/text.dart';

class FormsOverview extends StatelessWidget {
  const FormsOverview({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: itemPaddingSmall(bottom: true),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            AppButton(
              borderRadius: borderRadiusTiny,
              smallLeftPadding: true,
              child: Row(
                children: [
                  AppIcon(Icons.question_answer, size: 16, faded: true, bgColor: item.color()),
                  spw(),
                  Expanded(child: AppText(text: 'Responses:', bgColor: item.color())),
                  spw(),
                  AppText(
                    text: item.data.keys.where((key) => key.toString().startsWith('qr')).length.toString(),
                    fontWeight: FontWeight.bold,
                    faded: true,
                    bgColor: item.color(),
                  ),
                ],
              ),
            ),
            //
          ],
        ),
      ),
    );
  }
}
