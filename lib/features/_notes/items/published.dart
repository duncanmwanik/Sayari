import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/clipboard.dart';
import '../../../_models/item.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';

class PublishedItem extends StatelessWidget {
  const PublishedItem({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4.5),
      child: AppButton(
        onPressed: () => copyToClipboard(item.sharedLink()),
        tooltip: 'Copy link',
        padding: paddingC('l5,r5,t3,b3'),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppIcon(Icons.share, faded: true, size: tiny),
            tpw(),
            AppText(text: 'Shared${item.isPublished() ? ' & Published' : ''}', bgColor: item.color(), size: tiny),
          ],
        ),
      ),
    );
  }
}
