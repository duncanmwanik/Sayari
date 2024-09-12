import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/abcs/buttons/close_button.dart';
import '../../_widgets/others/forms/input.dart';
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
        AppCloseButton(isX: true),
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
