import 'package:flutter/material.dart';

import '../../_helpers/navigation.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/colors.dart';
import '../../_widgets/buttons/action.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/forms/input.dart';
import '../../_widgets/menu/menu_item.dart';
import '../../_widgets/others/checkbox.dart';
import '../../_widgets/others/color.dart';
import '../../_widgets/others/color_menu.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/others/divider.dart';
import '_helpers/manage_flag.dart';

class Flag extends StatefulWidget {
  const Flag({
    super.key,
    this.flagId = '',
    this.flag = '',
    this.color = '0',
    this.onPressed,
    this.onDelete,
    this.isSelected = false,
  });

  final String flagId;
  final String flag;
  final String color;
  final Function()? onPressed;
  final Function()? onDelete;
  final bool isSelected;

  @override
  State<Flag> createState() => _FlagItemState();
}

class _FlagItemState extends State<Flag> {
  TextEditingController controller = TextEditingController();
  bool isEdit = false;
  bool isNew = false;
  String flagColor = '0';

  @override
  void initState() {
    controller.text = widget.flag;
    setState(() {
      flagColor = widget.color;
      isNew = widget.flagId.isEmpty;
    });
    super.initState();
  }

  void update() {
    String newFlag = controller.text.trim();
    if (newFlag.isNotEmpty) {
      if (isNew) {
        createFlag('$flagColor,$newFlag');
        setState(() {
          controller.clear();
          flagColor = '0';
        });
      } else {
        if (newFlag.isNotEmpty && (newFlag != widget.flag || flagColor != widget.color)) {
          editFlag(widget.flagId, '$flagColor,$newFlag');
        }
      }
    } else {
      setState(() {
        controller.text = widget.flag;
        flagColor = widget.color;
      });
    }

    setState(() => isEdit = false);
    hideKeyboard();
  }

  @override
  Widget build(BuildContext context) {
    Color? textColor = isNew ? null : backgroundColors[flagColor]!.textColor;
    Color? cursorColor = isNew ? white : backgroundColors[flagColor]!.textColor;

    return Padding(
      padding: padS('lrb'),
      child: Column(
        children: [
          //
          Row(
            children: [
              //
              if (isEdit)
                ColorButton(
                  isSmall: true,
                  menuItems: colorMenu(
                    showRemove: false,
                    selectedColor: flagColor,
                    onSelect: (newColor) => setState(() => flagColor = newColor),
                  ),
                  color: flagColor,
                ),
              if (isNew && !isEdit)
                AppButton(
                  onPressed: () => setState(() => isEdit = true),
                  noStyling: true,
                  isSquare: true,
                  child: AppIcon(Icons.add_rounded, faded: true, size: 18),
                ),
              if (!isNew && !isEdit) AppCheckBox(isChecked: widget.isSelected, onTap: widget.onPressed),
              //
              tpw(),
              //
              Expanded(
                child: AppButton(
                  onPressed: isEdit || isNew ? null : widget.onPressed,
                  color: isNew && !isEdit ? transparent : backgroundColors[flagColor]!.color,
                  hoverColor: transparent,
                  child: DataInput(
                    hintText: isNew ? 'Add Flag' : 'Flag',
                    controller: controller,
                    autofocus: isEdit,
                    fontSize: small,
                    maxLines: 3,
                    isDense: true,
                    enabled: isEdit || isNew,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => update(),
                    onTap: () => setState(() => isEdit = true),
                    textColor: textColor,
                    cursorColor: cursorColor,
                    color: transparent,
                    hoverColor: transparent,
                    contentPadding: noPadding,
                  ),
                ),
              ),
              //
              if (!isEdit && !isNew) spw(),
              if (!isEdit && !isNew)
                AppButton(
                  menuWidth: 200,
                  menuItems: [
                    MenuItem(label: 'Edit', leading: Icons.edit, onTap: () => setState(() => isEdit = true)),
                    MenuItem(label: 'Delete', leading: Icons.delete, onTap: () => deleteFlag(widget.flagId)),
                  ],
                  noStyling: true,
                  isSquare: true,
                  child: AppIcon(Icons.more_vert_rounded, size: 14, faded: true),
                ),
              //
            ],
          ),
          //
          if (isEdit) tph(),
          if (isEdit)
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //
                ActionButton(
                  onPressed: () => setState(() {
                    controller.text = widget.flag;
                    isEdit = false;
                    flagColor = widget.color;
                  }),
                  isCancel: true,
                ),
                spw(),
                ActionButton(onPressed: () => update(), label: widget.flag.isNotEmpty ? 'Save' : 'Add'),
                //
              ],
            ),
          //
          if (isNew) AppDivider(height: smallHeight()),
          //
        ],
      ),
    );
  }
}
