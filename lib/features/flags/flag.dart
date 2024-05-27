import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/_common/navigation.dart';
import '../../_variables/colors.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/abcs/buttons/color_button.dart';
import '../../_widgets/abcs/menu/menu_item.dart';
import '../../_widgets/others/checkbox.dart';
import '../../_widgets/others/color_menu.dart';
import '../../_widgets/others/forms/input.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';
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
      padding: itemPaddingSmall(left: true, right: true, bottom: true),
      child: Column(
        children: [
          //
          Row(
            children: [
              //
              widget.isNewFlag || isEdit
                  ? Container(
                      width: 25,
                      padding: itemPaddingSmall(bottom: true),
                      child: isEdit
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
                              padding: EdgeInsets.all(4),
                              child: AppIcon(Icons.add_rounded, faded: true, size: 18),
                            ),
                    )
                  : AppCheckBox(isChecked: widget.isSelected, onTap: widget.onPressed),
              //
              tpw(),
              //
              Expanded(
                child: AppButton(
                  onPressed: isEdit || widget.isNewFlag ? null : widget.onPressed,
                  noStyling: true,
                  borderRadius: borderRadiusSmall,
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
                    contentPadding: isEdit || widget.isNewFlag ? itemPadding() : itemPaddingMedium(),
                  ),
                ),
              ),
              //
              if (!isEdit && !widget.isNewFlag) spw(),
              if (!isEdit && !widget.isNewFlag)
                AppButton(
                  menuWidth: 200,
                  menuItems: [
                    MenuItem(label: 'Edit', iconData: Icons.edit, onTap: () => setState(() => isEdit = true)),
                    MenuItem(label: 'Delete', iconData: Icons.delete, onTap: () => deleteFlag(widget.flag)),
                  ],
                  noStyling: true,
                  child: AppIcon(Icons.more_vert_rounded, size: 14, faded: true),
                ),
              //
            ],
          ),
          //
          if (isEdit) sph(),
          //
          if (isEdit)
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //
                AppButton(
                  onPressed: () => setState(() {
                    controller.text = widget.flag;
                    isEdit = false;
                    flagColor = widget.color;
                  }),
                  smallVerticalPadding: true,
                  child: AppText(text: 'Cancel'),
                ),
                //
                spw(),
                //
                AppButton(
                  onPressed: () => update(),
                  color: styler.accentColor(),
                  smallVerticalPadding: true,
                  child: AppText(text: widget.flag.isNotEmpty ? 'Save' : 'Add', color: white),
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
