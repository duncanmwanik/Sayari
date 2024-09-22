import 'package:flutter/material.dart';

import '../../../../../__styling/variables.dart';
import '../../../../../_models/item.dart';
import '../../../../../_widgets/buttons/button.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../_spaces/_helpers/checks_space.dart';

class NewItemButton extends StatefulWidget {
  const NewItemButton({super.key, required this.item});

  final Item item;

  @override
  State<NewItemButton> createState() => _NewItemInputState();
}

class _NewItemInputState extends State<NewItemButton> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isAdmin(),
      child: AppButton(
        isSquare: true,
        showBorder: widget.item.hasColor(),
        color: styler.appColor(1),
        tooltip: 'Add Item',
        onPressed: () {
          // newItemFocusNode.requestFocus();
          // state.input.setInputData(typ: feature.items, id: widget.item.id);
        },
        child: AppIcon(Icons.add_rounded, size: 18, faded: true, bgColor: widget.item.color()),
      ),
    );
  }
}
