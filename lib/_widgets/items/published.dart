import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_models/item.dart';
import '../abcs/buttons/buttons.dart';
import '../others/text.dart';

class PublishedLabel extends StatelessWidget {
  const PublishedLabel({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: itemPaddingSmall(top: true),
      child: AppButton(
        onPressed: () {},
        color: Colors.green,
        borderRadius: borderRadiusTiny,
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: AppText(text: 'Pub', color: Colors.white, size: tiny),
      ),
    );
  }
}
