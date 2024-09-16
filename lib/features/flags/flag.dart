import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/_common/navigation.dart';
import '../../_variables/colors.dart';
import '../../_widgets/buttons/buttons.dart';
import '../../_widgets/buttons/color_button.dart';
import '../../_widgets/dialogs/dialog_buttons.dart';
import '../../_widgets/menu/menu_item.dart';
import '../../_widgets/others/checkbox.dart';
import '../../_widgets/others/color_menu.dart';
import '../../_widgets/others/forms/input.dart';
import '../../_widgets/others/icons.dart';
import '_helpers/manage_flag.dart';

class Flag extends StatefulWidget {
  const Flag({
    super.key,
    this.flag = '',
    this.color = '0',
    this.onPressed,
    this.onDelete,
    this.isSelected = false,
    this.isNewFlag = false,
  });

  final String flag;
  final String color;
  final Function()? onPressed;
  final Function()? onDelete;
  final bool isSelected;
  final bool isNewFlag;

  @override
  State<Flag> createState() => _FlagItemState();
}

class _FlagItemState extends State<Flag> {
  TextEditingController controller = TextEditingController();
  bool isEdit = false;
  String flagColor = '0';

  @override
  void initState() {
    controller.text = widget.flag;
    setState(() => flagColor = widget.color);
    super.initState();
  }

  void update() {
    String newFlag = controller.text.trim();
    if (newFlag.isNotEmpty) {
      if (widget.isNewFlag) {
        createFlag(newFlag, flagColor);
        setState(() {
          controller.clear();
          flagColor = '0';
        });
      } else {
        if (newFlag.isNotEmpty && (newFlag != widget.flag || flagColor != widget.color)) {
          editFlag(newFlag, flagColor, widget.flag);
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
    Color? textColor = widget.isNewFlag ? null : backgroundColors[flagColor]!.textColor;

    return Padding(
      padding: paddingS('lrb'),
      child: Column(
        children: [
          //
          Row(
            children: [
              //
              widget.isNewFlag || isEdit
                  ? isEdit
                      ? ColorButton(
                          isSmall: true,
                          menuItems: colorMenu(
                            selectedColor: flagColor,
                            onSelect: (newColor) => setState(() => flagColor = newColor),
                          ),
                          bgColor: flagColor,
                        )
                      : AppButton(
                          onPressed: () => setState(() => isEdit = true),
                          noStyling: true,
                          isSquare: true,
                          child: AppIcon(Icons.add_rounded, faded: true, size: 18),
                        )
                  : AppCheckBox(isChecked: widget.isSelected, onTap: widget.onPressed),
              //
              tpw(),
              //
              Expanded(
                child: AppButton(
                  onPressed: isEdit || widget.isNewFlag ? null : widget.onPressed,
                  noStyling: true,
                  padding: EdgeInsets.zero,
                  child: DataInput(
                    hintText: widget.isNewFlag ? 'Add Flag' : 'Flag',
                    controller: controller,
                    autofocus: isEdit,
                    maxLines: 3,
                    isDense: true,
                    enabled: isEdit || widget.isNewFlag,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => update(),
                    onTap: () => setState(() => isEdit = true),
                    textColor: textColor,
                    borderRadius: borderRadiusTinySmall,
                    color: widget.isNewFlag ? (isEdit ? null : transparent) : backgroundColors[flagColor]!.color,
                    contentPadding: isEdit || widget.isNewFlag ? padding() : paddingM(),
                  ),
                ),
              ),
              //
              if (!isEdit && !widget.isNewFlag) spw(),
              if (!isEdit && !widget.isNewFlag)
                AppButton(
                  menuWidth: 200,
                  menuItems: [
                    MenuItem(label: 'Edit', leading: Icons.edit, onTap: () => setState(() => isEdit = true)),
                    MenuItem(label: 'Delete', leading: Icons.delete, onTap: () => deleteFlag(widget.flag)),
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
          //
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
                //
                spw(),
                //
                ActionButton(
                  onPressed: () => update(),
                  label: widget.flag.isNotEmpty ? 'Save' : 'Add',
                ),
                //
              ],
            ),
          //
          if (isEdit) sph()
          //
        ],
      ),
    );
  }
}
