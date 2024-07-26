import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../_models/item.dart';
import '../../features/files/file_list.dart';
import '../../features/labels/label_list.dart';
import '../../features/reminders/reminder.dart';

class ItemDetails extends StatelessWidget {
  const ItemDetails({super.key, this.item});

  final Item? item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: itemPadding(top: true),
      child: item != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                if (item!.reminder().isNotEmpty)
                  Reminder(type: item!.type, itemId: item!.id, reminder: item!.reminder(), bgColor: item!.color()),
                //
                if (item!.labels().isNotEmpty)
                  LabelList(type: item!.type, itemId: item!.id, labels: item!.labels(), bgColor: item!.color()),
                //
                if (item!.files().isNotEmpty) FileList(fileData: item!.files(), isOverview: true),
                //
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                Reminder(),
                //
                LabelList(),
                //
                FileList(),
                //
              ],
            ),
    );
  }
}
