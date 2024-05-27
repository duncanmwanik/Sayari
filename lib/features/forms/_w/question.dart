import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/global.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_providers/providers.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/abcs/dialogs_sheets/confirmation_dialog.dart';
import '../../../_widgets/abcs/dialogs_sheets/dialog_buttons.dart';
import '../../../_widgets/others/forms/input.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../../_widgets/others/toast.dart';

class FormItem extends StatefulWidget {
  const FormItem({super.key, required this.index, required this.linkId, required this.linkData});

  final int index;
  final String linkId;
  final Map linkData;

  @override
  State<FormItem> createState() => _HabitWeekState();
}

class _HabitWeekState extends State<FormItem> {
  TextEditingController titleController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    setState(() {
      titleController.text = widget.linkData['qt'] ?? '';
      linkController.text = widget.linkData['ql'] ?? '';
      isEdit = widget.linkData.isEmpty;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppButton(
      borderRadius: borderRadiusMediumSmall,
      color: styler.appColor(styler.isDark ? 0.5 : 1),
      padding: itemPadding(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //
              AppText(text: 'Question 1', faded: true),
              //
              Flexible(
                child: Wrap(
                  children: [
                    //
                    if (!isEdit)
                      AppButton(
                        onPressed: () async {
                          if (!isEdit) setState(() => isEdit = true);
                        },
                        noStyling: true,
                        isSquare: true,
                        child: AppIcon(Icons.edit, size: 16, faded: true),
                      ),
                    //
                    if (isEdit)
                      AppButton(
                        onPressed: () => showConfirmationDialog(
                          title: 'Remove question?',
                          yeslabel: 'Remove',
                          onAccept: () {
                            List linkOrderList = getSplitList(state.input.data['qo']);
                            linkOrderList.remove(widget.linkId);
                            state.input.update(action: 'add', key: 'qo', value: getJoinedList(linkOrderList));
                          },
                        ),
                        noStyling: true,
                        isSquare: true,
                        child: AppIcon(Icons.delete_outline_rounded, faded: true),
                      ),
                    spw(),
                    if (!isEdit)
                      ReorderableDragStartListener(
                        index: widget.index,
                        child: AppButton(
                          noStyling: true,
                          isSquare: true,
                          child: AppIcon(Icons.drag_indicator, faded: true),
                        ),
                      ),
                    //
                  ],
                ),
              ),
              //
            ],
          ),
          //
          sph(),
          //
          DataInput(
            hintText: 'Question',
            controller: titleController,
            textCapitalization: TextCapitalization.sentences,
            onChanged: (_) {
              if (!isEdit) setState(() => isEdit = true);
            },
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          ),
          //
          sph(),
          //
          DataInput(
            hintText: 'Choice',
            controller: linkController,
            onChanged: (_) {
              if (!isEdit) setState(() => isEdit = true);
            },
            prefix: AppIcon(Icons.link),
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          ),
          //
          sph(),
          //
          if (isEdit)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //
                ActionButton(
                  isCancel: true,
                  onPressed: () {
                    setState(() {
                      titleController.text = widget.linkData['qt'] ?? '';
                      linkController.text = widget.linkData['ql'] ?? '';
                      isEdit = false;
                    });
                  },
                ),
                //
                if (isEdit)
                  ActionButton(
                    onPressed: () {
                      if (titleController.text.trim().isNotEmpty) {
                        Map linkData = {
                          'qq': titleController.text.trim(),
                          'qc': linkController.text.trim(),
                        };
                        state.input.update(action: 'add', key: widget.linkId, value: jsonEncode(linkData));
                        setState(() => isEdit = false);
                        hideKeyboard();
                      } else {
                        showToast(0, 'Title is required.');
                      }
                    },
                    label: isEdit ? 'Save' : 'Add',
                  ),
                //
              ],
            )
          //
        ],
      ),
    );
  }
}
