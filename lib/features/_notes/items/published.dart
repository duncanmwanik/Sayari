import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/misc.dart';
import '../../../_models/item.dart';
import '../../../_widgets/buttons/button.dart';
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
        color: styler.accent,
        padding: paddingC('l5,r5,t2,b2'),
        child: AppText(text: 'Published in blog', color: Colors.white, size: tiny),
      ),
    );
  }
}
