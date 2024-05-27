import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../_helpers/_common/global.dart';
import '../../../_providers/common/input.dart';
import '../../../_widgets/layout/orderables/background.dart';
import 'question.dart';

class QuestionsList extends StatefulWidget {
  const QuestionsList({super.key});

  @override
  State<QuestionsList> createState() => _HabitWeekState();
}

class _HabitWeekState extends State<QuestionsList> {
  List days = [];
  int startDate = 0;
  int endDate = 7;

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      List linkKeys = getSplitList(input.data['qo']);

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          msph(),
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
              List links = getSplitList(input.data['qo']);
              String orderedId = links.removeAt(oldIndex);
              links.insert(newIndex, orderedId);
              input.update(action: 'add', key: 'qo', value: getJoinedList(links));
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
                  child: FormItem(index: index, linkId: linkId, linkData: linkData),
                ),
              );
            },
          ),
          //
          sph(),
          //
        ],
      );
    });
  }
}
