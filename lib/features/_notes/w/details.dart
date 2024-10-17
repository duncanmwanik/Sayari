import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_helpers/sync/quick_edit.dart';
import '../../../_models/item.dart';
import '../../../_providers/_providers.dart';
import '../../../_providers/input.dart';
import '../../../_variables/features.dart';
import '../../files/file_list.dart';
import '../../reminders/reminder.dart';
import '../../tags/tag_list.dart';

class ItemDetails extends StatelessWidget {
  const ItemDetails({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    if (item.exists()) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item.hasReminder()) Reminder(id: item.id, reminder: item.reminder(), bgColor: item.color()),
          if (item.hasTags())
            TagList(
              item: item,
              onUpdate: (newTags) => quickEdit(parent: feature.notes, id: item.id, key: newTags.isEmpty ? 'd/l' : 'l', value: newTags),
            ),
          if (item.hasFiles()) FileList(fileData: item.files(), bgColor: item.color(), isOverview: true),
        ],
      );
    } else {
      return Consumer<InputProvider>(
          builder: (x, input, c) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Reminder(),
                  TagList(
                    item: input.item,
                    onUpdate: (newTags) => newTags.isEmpty ? state.input.remove('l') : state.input.update('l', newTags),
                  ),
                  FileList(),
                ],
              ));
    }
  }
}
