import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/others/icons.dart';
import 'search_sheet.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: itemPadding(right: true),
      child: AppButton(
        onPressed: () => showSearchSheet(),
        tooltip: 'Search',
        isRound: true,
        noStyling: true,
        child: AppIcon(Icons.search_rounded, faded: true),
      ),
    );
  }
}
