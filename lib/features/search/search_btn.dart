import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/others/icons.dart';
import 'search_sheet.dart';

List g = [];

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingM('r'),
      child: AppButton(
        onPressed: () => showSearchSheet(),
        tooltip: 'Search',
        isSquare: true,
        noStyling: true,
        child: AppIcon(Icons.search_rounded, faded: true),
      ),
    );
  }
}
