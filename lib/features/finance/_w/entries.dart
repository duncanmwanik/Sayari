import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../_providers/common/input.dart';
import '../_helpers/helpers.dart';
import 'entry.dart';
import 'entry_filter.dart';

class Entries extends StatefulWidget {
  const Entries({super.key});

  @override
  State<Entries> createState() => _EntriesState();
}

class _EntriesState extends State<Entries> {
  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      Map entriesMap = getEntriesMap(input.filter == 'All' ? ['in', 'ex', 'sa'] : [input.filter.substring(0, 2).toLowerCase()]);
      List entriesKeys = entriesMap.keys.toList();
      entriesKeys = entriesKeys.reversed.toList();

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //
          EntriesFilter(),
          //
          sph(),
          //
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              itemCount: entriesKeys.length,
              separatorBuilder: (context, index) => sph(),
              itemBuilder: (context, index) {
                String entryId = entriesKeys[index];
                Map entryData = entriesMap[entryId];

                return Entry(entryId: entryId, entryData: entryData);
              },
            ),
          ),
          //
        ],
      );
    });
  }
}
