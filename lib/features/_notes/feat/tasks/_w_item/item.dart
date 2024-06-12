import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../__styling/helpers.dart';
import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_helpers/_common/global.dart';
import '../../../../../_models/item.dart';
import '../../../../../_providers/providers.dart';
import '../../../../../_variables/features.dart';
import '../../../../../_widgets/others/checkbox.dart';
import '../../../../../_widgets/others/text.dart';
import '../../../../files/_helpers/helper.dart';
import '../../../../files/file_list.dart';
import '../../../../reminders/reminder.dart';
import '../../../_helpers/quick_edit.dart';
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
      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 2),
      child: InkWell(
        onTap: () async {
          state.input.setInputData(
              isNw: false,
              typ: feature.notes.t,
              itm: widget.item,
              id: widget.item.id,
              sId: widget.subItemId,
              dta: widget.subItemData);
          showItemDialog(widget.subItemId, widget.subItemData, widget.item.id);
        },
        onHover: (value) => setState(() => isHovered = value),
        borderRadius: BorderRadius.circular(borderRadiusSmall),
        hoverColor: transparent,
        child: Container(
          padding: itemPaddingMedium(left: true, bottom: true),
          decoration: BoxDecoration(
            color: styler.listItemColor(bgColor: widget.item.color()),
            borderRadius: BorderRadius.circular(borderRadiusSmall),
            border: Border.all(
              width: 0.75,
              color: (isHovered)
                  ? isImageTheme()
                      ? white
                      : styler.accentColor()
                  : styler.isDark
                      ? Colors.grey.withOpacity(0.2)
                      : Colors.grey.withOpacity(0.3),
            ),
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: itemPaddingMedium(top: true, right: true),
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
                        // Item Text
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //
                            if (widget.item.showChecks())
                              Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: AppCheckBox(
                                  isChecked: isChecked,
                                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                                  onTap: () {
                                    editItemExtras(
                                        type: feature.notes.t,
                                        itemId: widget.item.id,
                                        subId: widget.subItemId,
                                        key: 'v',
                                        value: isChecked ? '0' : '1');
                                  },
                                ),
                              ),
                            //
                            Expanded(
                              child: AppText(
                                text: widget.subItemData['t'] ?? '---',
                                fontWeight: FontWeight.w400,
                                bgColor: widget.item.color(),
                              ),
                            ),
                          ],
                        ),
                        //
                        if (reminder.isNotEmpty) kIsWeb ? mph() : msph(),
                        if (reminder.isNotEmpty)
                          Reminder(
                            type: feature.notes.t,
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
      ),
    );
  }
}
