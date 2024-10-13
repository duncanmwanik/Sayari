import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reorderables/reorderables.dart';

import '../../../__styling/spacing.dart';
import '../../../_models/item.dart';
import '../../../_services/hive/get_data.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/others/empty_box.dart';
import 'qt_item.dart';

class ListOfQuickTasks extends StatelessWidget {
  const ListOfQuickTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: storage(feature.timeline).listenable(keys: [feature.tasks]),
        builder: (context, box, child) {
          Map tasks = box.get(feature.tasks, defaultValue: {});

          return tasks.isNotEmpty
              ? Padding(
                  padding: paddingL('tb'),
                  child: ValueListenableBuilder(
                      valueListenable: storage(feature.timeline).listenable(),
                      builder: (context, box, child) {
                        return ReorderableWrap(
                          maxMainAxisCount: 1,
                          onReorder: (oldIndex, newIndex) {},
                          children: List.generate(box.length, (index) {
                            String id = tasks.keys.toList()[index];

                            return QuickTaskItem(item: Item(id: id, data: tasks[id]));
                          }),
                        );
                      }),
                )
              : EmptyBox(label: 'No quick tasks yet...', showImage: false);
        });
  }
}
