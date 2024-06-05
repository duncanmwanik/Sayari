import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../_providers/common/input.dart';
import '../../../../../_widgets/abcs/buttons/buttons.dart';

class FinanceToggler extends StatelessWidget {
  const FinanceToggler({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(
      builder: (context, input, child) => AppButton(
        isSquare: true,
        noStyling: true,
        tooltip: input.data['cx'] == '1' ? 'Show more' : 'Show less',
        leading: input.data['cx'] == '1' ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
        onPressed: () => input.update(action: 'add', key: 'cx', value: input.data['cx'] == '1' ? '0' : '1'),
      ),
    );
  }
}
