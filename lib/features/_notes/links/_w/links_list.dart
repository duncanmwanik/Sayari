import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

import '../../../../__styling/spacing.dart';
import '../../../../_helpers/_common/global.dart';
import '../../../../_providers/input.dart';
import 'link_item.dart';

class LinksList extends StatefulWidget {
  const LinksList({super.key});

  @override
  State<LinksList> createState() => _HabitWeekState();
}

class _HabitWeekState extends State<LinksList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      List linkKeys = getSplitList(input.data['lo']);

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          ReorderableWrap(
            key: UniqueKey(),
            runSpacing: tinyHeight(),
            maxMainAxisCount: 1,
            padding: EdgeInsets.zero,
            onReorder: (oldIndex, newIndex) {
              if (newIndex > linkKeys.length) newIndex = linkKeys.length;
              if (oldIndex < newIndex) newIndex--;
              //
              List links = getSplitList(input.data['lo']);
              String orderedId = links.removeAt(oldIndex);
              links.insert(newIndex, orderedId);
              input.update('lo', getJoinedList(links));
              setState(() {});
            },
            children: List.generate(linkKeys.length, (index) {
              String linkId = linkKeys[index];
              Map linkData = jsonDecode(input.data[linkId]);

              return Padding(
                padding: paddingM('t'),
                child: LinkItem(index: index, linkId: linkId, linkData: linkData),
              );
            }),
          ),
          //
          mph(),
          //
        ],
      );
    });
  }
}
