import 'package:flutter/material.dart';

import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/buttons/close.dart';
import '../../_widgets/forms/input.dart';
import '../../_widgets/others/icons.dart';
import '_helpers/search.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppCloseButton(),
        spw(),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 6),
            child: DataInput(
              hintText: 'Search...',
              controller: controller,
              onFieldSubmitted: (text) => doSearch(text),
              color: styler.textColor(faded: true),
              maxLines: 3,
              filled: false,
              autofocus: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
        spw(),
        AppButton(
          onPressed: () => controller.clear(),
          tooltip: 'Clear',
          noStyling: true,
          isSquare: true,
          child: AppIcon(Icons.clear, faded: true),
        ),
        spw(),
        AppButton(
          onPressed: () => doSearch(controller.text),
          tooltip: 'Search',
          noStyling: true,
          isSquare: true,
          child: AppIcon(Icons.arrow_forward, faded: true),
        ),
      ],
    );
  }
}
