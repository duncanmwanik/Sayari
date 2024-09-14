import 'package:flutter/material.dart';

import '../../../__styling/variables.dart';
import '../../../_models/item.dart';
import '../../../_widgets/buttons/buttons.dart';
import '../../../_widgets/others/text.dart';

class PublishedLabel extends StatelessWidget {
  const PublishedLabel({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4.5),
      child: AppButton(
        onPressed: () {},
        color: styler.accent,
        borderRadius: borderRadiusTiny,
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: AppText(text: 'Blog', color: Colors.white, size: tiny),
      ),
    );
  }
}
