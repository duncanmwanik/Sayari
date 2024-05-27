import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_models/item.dart';
import '../../../_providers/common/input.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';

class LinksOverview extends StatelessWidget {
  const LinksOverview({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      return Align(
        alignment: Alignment.center,
        child: Padding(
          padding: itemPaddingSmall(bottom: true),
          child: AppButton(
            borderRadius: borderRadiusSmall,
            smallLeftPadding: true,
            child: Row(
              children: [
                AppIcon(Icons.dataset_linked_outlined, size: 16, faded: true, bgColor: item.bgColor()),
                spw(),
                Expanded(child: AppText(text: 'Links', bgColor: item.bgColor())),
                mpw(),
                AppText(
                  text: item.data.keys.where((key) => key.toString().startsWith('wk')).length.toString(),
                  fontWeight: FontWeight.bold,
                  faded: true,
                  bgColor: item.bgColor(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
