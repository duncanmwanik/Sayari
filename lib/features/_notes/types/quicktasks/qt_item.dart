import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_helpers/sync/delete_item.dart';
import '../../../../_helpers/sync/quick_edit.dart';
import '../../../../_models/item.dart';
import '../../../../_providers/focus.dart';
import '../../../../_providers/input.dart';
import '../../../../_theme/helpers.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_theme/variables.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/forms/input.dart';
import '../../../../_widgets/others/checkbox.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/others/other.dart';
import '../tasks/_helpers/quicktask_helpers.dart';
import 'qt_menu.dart';

class QuickTaskItem extends StatelessWidget {
  const QuickTaskItem({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Consumer2<FocusProvider, InputProvider>(
      builder: (context, focus, input, child) {
        bool hasFocus = focus.id == 'newQuickTask';
        bool isNew = hasFocus && item.data.isEmpty;
        bool isEdit = focus.id == item.sid;
        bool isAction = isEdit || isNew;
        bool isChecked = isAction ? input.item.isChecked() : item.isChecked();

        return Visibility(
          visible: isNew || item.data.isNotEmpty,
          child: Dismissible(
            key: Key(focus.id),
            background: NoWidget(),
            direction: isAction ? DismissDirection.none : DismissDirection.horizontal,
            onDismissed: (_) => deleteItemForever(item),
            child: AppButton(
              blur: isImage(),
              color: styler.appColor(isDark() ? 0.1 : 0.3),
              hoverColor: styler.appColor(isDark() ? 0.1 : 0.3),
              padding: padS(),
              onPressed: isAction
                  ? null
                  : () => quickEdit(parent: item.parent, id: item.id, sid: item.sid, key: 'v', value: isChecked ? '0' : '1'),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // checkbox
                  if (!isAction)
                    AppCheckBox(
                      margin: pad(c: 'l2,t2'),
                      isChecked: isChecked,
                      onTap: () => quickEdit(parent: item.parent, id: item.id, sid: item.sid, key: 'v', value: isChecked ? '0' : '1'),
                    ),
                  // cancel
                  if (isAction)
                    AppButton(
                      onPressed: () => focus.reset(),
                      noStyling: true,
                      isSquare: true,
                      child: AppIcon(Icons.close, faded: true),
                    ),
                  mspw(),
                  Expanded(
                    child: Padding(
                      padding: pad(c: 't6'),
                      child: DataInput(
                        hintText: 'Task',
                        initialValue: isAction ? null : item.title(),
                        color: transparent,
                        weight: isDark() ? FontWeight.w400 : FontWeight.w500,
                        hoverColor: transparent,
                        autofocus: isAction,
                        enabled: isAction,
                        contentPadding: noPadding,
                        onFieldSubmitted: (_) => isNew ? addQuickTask() : editQuickTask(),
                      ),
                    ),
                  ),
                  mpw(),
                  // save task
                  if (isAction)
                    AppButton(
                      onPressed: () => isNew ? addQuickTask() : editQuickTask(),
                      noStyling: true,
                      isSquare: true,
                      child: AppIcon(Icons.done),
                    ),
                  // actions
                  if (!isAction)
                    AppButton(
                      menuItems: qtMenu(item),
                      isSquare: true,
                      noStyling: true,
                      child: AppIcon(Icons.more_horiz, faded: true),
                    ),
                  //
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
