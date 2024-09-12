import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../_helpers/_common/global.dart';
import '../../../../../_providers/common/input.dart';
import '../../../../../_widgets/layout/orderables/background.dart';
import 'link_item.dart';

class LinksList extends StatefulWidget {
  const LinksList({super.key});

  @override
  State<LinksList> createState() => _HabitWeekState();
}

class _HabitWeekState extends State<LinksList> {
  List days = [];
  int startDate = 0;
  int endDate = 7;

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      List linkKeys = getSplitList(input.data['lo']);

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          ReorderableListView.builder(
            shrinkWrap: true,
            buildDefaultDragHandles: false,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            proxyDecorator: (child, index, animation) => proxyDecorator(child, index, animation),
            onReorder: (oldIndex, newIndex) {
              if (newIndex > linkKeys.length) newIndex = linkKeys.length;
              if (oldIndex < newIndex) newIndex--;
              //
              List links = getSplitList(input.data['lo']);
              String orderedId = links.removeAt(oldIndex);
              links.insert(newIndex, orderedId);
              input.update(action: 'add', key: 'lo', value: getJoinedList(links));
              setState(() {});
            },
            itemCount: linkKeys.length,
            itemBuilder: (context, index) {
              String linkId = linkKeys[index];
              Map linkData = jsonDecode(input.data[linkId]);

              return ReorderableDelayedDragStartListener(
                index: index,
                key: ValueKey(index),
                child: Padding(
                  padding: itemPaddingMedium(top: true),
                  child: LinkItem(index: index, linkId: linkId, linkData: linkData),
                ),
              );
            },
          ),
          //
          mph(),
          //
        ],
      );
    });
  }
}
