import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../_models/item.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';

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
            Row(
              children: [
                AppIcon(Icons.dataset_linked_outlined, size: 16, faded: true, bgColor: item.bgColor()),
                spw(),
                Flexible(
                  child: AppText(
                    text: 'Questions    ${item.data.keys.where((key) => key.toString().startsWith('qq')).length}',
                    bgColor: item.bgColor(),
                  ),
                ),
              ],
            ),
            //
            sph(),
            //
            Row(
              children: [
                AppIcon(Icons.question_answer, size: 16, faded: true, bgColor: item.bgColor()),
                spw(),
                Flexible(
                  child: AppText(
                    text: 'Responses    ${item.data.keys.where((key) => key.toString().startsWith('qr')).length}',
                    bgColor: item.bgColor(),
                  ),
                ),
              ],
            ),
            //
          ],
        ),
      ),
    );
  }
}
