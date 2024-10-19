import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reorderables/reorderables.dart';

import '../../../../_models/item.dart';
import '../../../../_services/hive/store.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_variables/features.dart';
import '../../../../_widgets/others/text.dart';
import 'qt_item.dart';

class ListOfQuickTasks extends StatelessWidget {
  const ListOfQuickTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: storage(feature.timeline).listenable(keys: [feature.tasks]),
        builder: (context, box, child) {
          Map tasks = box.get(feature.tasks, defaultValue: {});
          List taskKeys = tasks.keys.toList();
          taskKeys.sort((a, b) => int.parse(tasks[a]['o']).compareTo(int.parse(tasks[b]['o'])));

          return Padding(
            padding: padM('t'),
            child: ValueListenableBuilder(
                valueListenable: storage(feature.timeline).listenable(),
                builder: (context, box, child) {
                  return ReorderableWrap(
                    maxMainAxisCount: 1,
                    spacing: smallWidth(),
                    runSpacing: tinyWidth(),
                    onReorder: (oldIndex, newIndex) {},
                    // onReorder: (oldIndex, newIndex) => orderSubItem(
                    //   parent: feature.timeline,
                    //   itemId: feature.tasks,
                    //   oldItemId: taskKeys[oldIndex - 1],
                    //   newItemId: taskKeys[newIndex - 1],
                    //   itemsLength: taskKeys.length,
                    //   oldIndex: oldIndex,
                    //   newIndex: newIndex,
                    // ),
                    children: [
                      // new task
                      QuickTaskItem(item: Item.empty()),
                      // task list
                      for (String id in taskKeys)
                        QuickTaskItem(item: Item(parent: feature.timeline, id: feature.tasks, sid: id, data: tasks[id])),
                      //
                      if (taskKeys.isEmpty) Padding(padding: padL('lb'), child: AppText(text: 'No quick tasks...', extraFaded: true)),
                      //
                    ],
                  );
                }),
          );
        });
  }
}
