import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../abcs/buttons/buttons.dart';
import 'icons.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: itemPadding(right: true),
      child: AppButton(
        onPressed: () {},
        tooltip: 'Search',
        isRound: true,
        noStyling: true,
        child: AppIcon(Icons.search_rounded, faded: true),
      ),
    );
  }
}
