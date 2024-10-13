import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reorderables/reorderables.dart';

import '../../../__styling/spacing.dart';
import '../../../_models/item.dart';
import '../../../_services/hive/get_data.dart';
import '../../../_variables/features.dart';
import 'qt_item.dart';

class ListOfQuickTasks extends StatelessWidget {
  const ListOfQuickTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: storage(feature.timeline).listenable(keys: [feature.tasks]),
        builder: (context, box, child) {
          return Padding(
            padding: paddingL('tb'),
            child: ValueListenableBuilder(
                valueListenable: storage(feature.timeline).listenable(),
                builder: (context, box, child) {
                  return ReorderableWrap(
                    maxMainAxisCount: 1,
                    onReorder: (oldIndex, newIndex) {},
                    children: List.generate(box.length, (index) {
                      return QuickTaskItem(item: Item(id: box.keyAt(index), data: box.getAt(index)));
                    }),
                  );
                }),
          );
        });
  }
}
