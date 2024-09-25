import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../__styling/helpers.dart';
import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_helpers/_common/global.dart';
import '../../../../_models/item.dart';
import '../../../../_providers/_providers.dart';
import '../../../../_variables/features.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/others/checkbox.dart';
import '../../../../_widgets/others/text.dart';
import '../../../files/_helpers/helper.dart';
import '../../../files/file_list.dart';
import '../../../reminders/reminder.dart';
import '../../_helpers/quick_edit.dart';
import 'flag_list.dart';
import 'item_dialog.dart';

class SubItem extends StatefulWidget {
  const SubItem({super.key, required this.subItemId, required this.subItemData, required this.item});

  final String subItemId;
  final Map subItemData;
  final Item item;

  @override
  State<SubItem> createState() => _ItemState();
}

class _ItemState extends State<SubItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    String reminder = widget.subItemData['r'] ?? '';
    bool isChecked = widget.subItemData['v'] == '1';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      child: AppButton(
        onPressed: () async {
          state.input.setInputData(
              isNw: false, typ: feature.notes, itm: widget.item, id: widget.item.id, sId: widget.subItemId, dta: widget.subItemData);
          showItemDialog(widget.subItemId, widget.subItemData, widget.item.id);
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
                      ItemFlagList(flagList: getSplitList(widget.subItemData['g']), isTinyFlag: true),
                      //
                      if (hasFlagList(widget.subItemData['g'])) sph(),
                      //
                      FileList(fileData: getFiles(widget.subItemData)),
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
                                      type: feature.notes,
                                      itemId: widget.item.id,
                                      subId: widget.subItemId,
                                      key: 'v',
                                      value: isChecked ? '0' : '1');
                                },
                              ),
                            ),
                          // text
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: 1),
                              child: AppText(
                                text: widget.subItemData['t'] ?? 'No description',
                                bgColor: widget.item.color(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //
                      if (reminder.isNotEmpty) kIsWeb ? mph() : msph(),
                      if (reminder.isNotEmpty)
                        Reminder(
                          type: feature.notes,
                          itemId: widget.item.id,
                          subId: widget.subItemId,
                          reminder: reminder,
                          bgColor: widget.item.color(),
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
