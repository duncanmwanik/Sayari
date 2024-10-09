import 'package:flutter/material.dart';

import '../../../__styling/helpers.dart';
import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_models/item.dart';
import '../../../_providers/_providers.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/checkbox.dart';
import '../../../_widgets/others/text.dart';
import '../../files/file_list_overview.dart';
import '../../reminders/reminder.dart';
import '../_helpers/quick_edit.dart';
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
    String reminder = widget.sitem.reminder();
    bool isChecked = widget.sitem.isChecked();

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
          padding: padding(l: widget.item.showChecks() ? 4 : 7, t: 6, r: 6, b: 6),
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
                                isChecked: isChecked,
                                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                                onTap: () {
                                  editItemExtras(
                                      parent: feature.notes,
                                      id: widget.sitem.id,
                                      sid: widget.sitem.sid,
                                      key: 'v',
                                      value: isChecked ? '0' : '1');
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
                            if (widget.sitem.hasFiles()) FileListOverview(item: widget.sitem),
                            // reminder
                            if (reminder.isNotEmpty)
                              Reminder(
                                id: widget.sitem.id,
                                sid: widget.sitem.sid,
                                reminder: widget.sitem.reminder(),
                                bgColor: widget.item.color(),
                              ),
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
