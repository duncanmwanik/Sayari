import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/spacing.dart';
import '../../_providers/common/input.dart';
import '../../_providers/providers.dart';
import '../../_variables/features.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/items/date.dart';
import '../files/file_overview.dart';
import '_w/add_entry.dart';
import '_w/entries.dart';
import '_w/goals.dart';

class Finance extends StatelessWidget {
  const Finance({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(
      builder: (context, input, child) => Visibility(
        visible: input.data[feature.finances.lt] != null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            ImageOverview(isInput: true),
            //
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppButton(
                  isSquare: true,
                  tooltip: input.data['cx'] == '1' ? 'Show more' : 'Show less',
                  leading: state.input.data['cx'] == '1' ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                  onPressed: () =>
                      state.input.update(action: 'add', key: 'cx', value: input.data['cx'] == '1' ? '0' : '1'),
                ),
              ],
            ),
            //
            Dates(showIcon: false),
            //
            Goals(),
            //
            sph(),
            //
            AddEntry(),
            //
            sph(),
            //
            Entries(),
            //
            spph(),
            //
          ],
        ),
      ),
    );
  }
}
