import 'package:flutter/material.dart';

import '../../../_helpers/_common/helpers.dart';
import '../../../_models/item.dart';
import '../../files/file_list.dart';
import '../../labels/list_of_labels.dart';
import '../../reminders/reminder.dart';

class ItemDetails extends StatelessWidget {
  const ItemDetails({super.key, this.item = const Item()});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !isShare(),
      child: item.data.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                if (item.reminder().isNotEmpty)
                  Reminder(type: item.type, itemId: item.id, reminder: item.reminder(), bgColor: item.color()),
                //
                if (item.labels().isNotEmpty) LabelList(type: item.type, itemId: item.id, labels: item.labels(), bgColor: item.color()),
                //
                if (item.hasFiles()) FileList(fileData: item.files(), bgColor: item.color(), isOverview: true),
                //
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                Reminder(),
                LabelList(),
                FileList(),
                //
              ],
            ),
    );
  }
}
