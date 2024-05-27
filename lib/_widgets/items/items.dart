import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_models/item.dart';
import '../../_providers/common/selection.dart';
import '../../features/files/file_list.dart';
import '../../features/labels/label_list.dart';
import '../../features/reminders/reminder.dart';
import '../abcs/buttons/buttons.dart';
import '../others/icons.dart';
import '../others/text.dart';
import 'item_selection.dart';
import 'pinned.dart';

class ItemActions extends StatelessWidget {
  const ItemActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectionProvider>(builder: (context, selection, child) {
      return Visibility(
        visible: selection.selected.isNotEmpty,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: SelectedItemOptions(),
        ),
      );
    });
  }
}

class ItemHeader extends StatelessWidget {
  const ItemHeader({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 5, top: 6),
      child: Row(
        children: [
          //
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(child: AppText(size: normal, text: item.title(), bgColor: item.bgColor(), maxlines: 2, fontWeight: FontWeight.w700)),
                if (item.isShared()) spw(),
                if (item.isShared() && !item.isPublished()) AppIcon(Icons.share, size: 14, faded: true, bgColor: item.bgColor()),
                if (item.isPublished())
                  AppButton(
                    color: Colors.green,
                    borderRadius: borderRadiusTiny,
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    child: AppText(text: 'Published', color: Colors.white, size: tiny),
                  ),
              ],
            ),
          ),
          //
          if (!item.hasOverview()) PinnedIcon(item: item),
          //
        ],
      ),
    );
  }
}

class ItemDetails extends StatelessWidget {
  const ItemDetails({super.key, this.item});

  final Item? item;

  @override
  Widget build(BuildContext context) {
    if (item != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          if (item!.reminder().isNotEmpty || item!.labels().isNotEmpty || item!.files().isNotEmpty) sph(),
          //
          if (item!.reminder().isNotEmpty) Reminder(type: item!.type, itemId: item!.id, reminder: item!.reminder(), bgColor: item!.bgColor()),
          //
          if (item!.labels().isNotEmpty) LabelList(type: item!.type, itemId: item!.id, labels: item!.labels(), bgColor: item!.bgColor()),
          //
          if (item!.files().isNotEmpty) FileList(fileData: item!.files(), isOverview: true),
          //
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          tph(),
          //
          Reminder(),
          //
          LabelList(),
          //
          FileList(),
          //
          tph(),
          //
        ],
      );
    }
  }
}
