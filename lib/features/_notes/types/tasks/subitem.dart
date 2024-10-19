import 'package:flutter/material.dart';

import '../../../../_helpers/sync/quick_edit.dart';
import '../../../../_models/item.dart';
import '../../../../_providers/_providers.dart';
import '../../../../_theme/helpers.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_theme/variables.dart';
import '../../../../_variables/features.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/others/checkbox.dart';
import '../../../../_widgets/others/text.dart';
import '../../../files/file_list_overview.dart';
import '../../../reminders/reminder.dart';
import 'w_items/edit_subitem.dart';
import 'w_items/flag_list.dart';

class SubItem extends StatefulWidget {
  const SubItem({super.key, required this.sitem, required this.item});

  final Item item;
  final Item sitem;

  @override
  State<SubItem> createState() => _ItemState();
}

class _ItemState extends State<SubItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      child: AppButton(
        onPressed: () async {
          state.input.set(widget.sitem);
          showItemDialog(widget.sitem);
        },
        onHover: (value) => setState(() => isHovered = value),
        hoverColor: transparent,
        noStyling: true,
        padding: noPadding,
        child: Container(
          padding: widget.item.showChecks() ? pad(c: 'l4,r6,t6,b6') : padMS(),
          decoration: BoxDecoration(
            color: styler.listItemColor(bgColor: widget.item.color()),
            borderRadius: BorderRadius.circular(borderRadiusTiny),
            border: Border.all(
              width: 0.8,
              color: (isHovered)
                  ? isImage()
                      ? white
                      : styler.accentColor()
                  : isImage()
                      ? white.withOpacity(0.3)
                      : styler.isDark
                          ? styler.appColor(2)
                          : styler.appColor(3),
            ),
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //
                      ItemFlagList(flagList: widget.sitem.flags(), isTinyFlag: true),
                      if (widget.sitem.hasFlags()) sph(),
                      //
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // checkbox
                          if (widget.item.showChecks())
                            Padding(
                              padding: EdgeInsets.only(right: 6),
                              child: AppCheckBox(
                                isChecked: widget.sitem.isChecked(),
                                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                                onTap: () {
                                  quickEdit(
                                      parent: feature.notes,
                                      id: widget.sitem.id,
                                      sid: widget.sitem.sid,
                                      key: 'v',
                                      value: widget.sitem.isChecked() ? '0' : '1');
                                },
                              ),
                            ),
                          // text
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: 1),
                              child: AppText(text: widget.sitem.title(), bgColor: widget.item.color()),
                            ),
                          ),
                        ],
                      ),
                      //
                      if (widget.sitem.hasReminder() || widget.sitem.hasFiles()) msph(),
                      if (widget.sitem.hasReminder() || widget.sitem.hasFiles())
                        Wrap(
                          spacing: tinyWidth(),
                          runSpacing: tinyWidth(),
                          children: [
                            // files
                            if (widget.sitem.hasFiles()) FileListOverview(item: widget.item, sitem: widget.sitem),
                            // reminder
                            if (widget.sitem.hasReminder()) Reminder(item: widget.sitem),
                          ],
                        ),
                    ],
                  ),
                ),
                //
                spw(),
                //
              ],
            ),
          ),
        ),
      ),
    );
  }
}
