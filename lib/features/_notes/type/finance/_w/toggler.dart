import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../_providers/input.dart';
import '../../../../../_widgets/buttons/button.dart';

class FinanceToggler extends StatelessWidget {
  const FinanceToggler({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(
      builder: (context, input, child) {
        bool isExpanded = input.data['cx'] == '1' || input.data['cx'] == null;

        return AppButton(
          isSquare: true,
          noStyling: true,
          tooltip: isExpanded ? 'Show more' : 'Show less',
          leading: isExpanded ? Icons.more_horiz : Icons.keyboard_arrow_up,
          onPressed: () => input.update('cx', isExpanded ? '0' : '1'),
        );
      },
    );
  }
}
