import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../__styling/spacing.dart';
import '../../../../_providers/input.dart';
import '../../../../_variables/features.dart';
import '../../w/date.dart';
import '_w/add_entry.dart';
import '_w/entries.dart';
import '_w/goals.dart';

class Finance extends StatelessWidget {
  const Finance({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(
      builder: (context, input, child) {
        return Visibility(
          visible: input.item.data[feature.finances] != null,
          child: Padding(
            padding: paddingS('t'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                Dates(showIcon: false),
                Goals(),
                AddEntry(),
                Entries(),
                spph(),
                //
              ],
            ),
          ),
        );
      },
    );
  }
}
