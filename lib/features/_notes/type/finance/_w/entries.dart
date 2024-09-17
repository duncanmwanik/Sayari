import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../_providers/common/input.dart';
import '../_helpers/helpers.dart';
import 'entry.dart';

class Entries extends StatelessWidget {
  const Entries({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      Map entriesMap = getEntriesMap(input.filter == 'All' ? ['in', 'ex', 'sa'] : [input.filter.substring(0, 2).toLowerCase()]);
      List entriesKeys = entriesMap.keys.toList();
      entriesKeys = entriesKeys.reversed.toList();

      return ListView.separated(
        shrinkWrap: true,
        padding: padding(s: 't'),
        physics: NeverScrollableScrollPhysics(),
        itemCount: entriesKeys.length,
        separatorBuilder: (context, index) => sph(),
        itemBuilder: (context, index) {
          String entryId = entriesKeys[index];
          Map entryData = entriesMap[entryId];

          return Entry(entryId: entryId, entryData: entryData);
        },
      );
    });
  }
}
