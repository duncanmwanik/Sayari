import 'package:flutter/material.dart';

import '../../__styling/variables.dart';
import '../../_helpers/navigation.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/forms/input.dart';
import '../../_widgets/others/icons.dart';
import '_helpers/add_label.dart';

class NewlabelInput extends StatefulWidget {
  const NewlabelInput({super.key, this.isPopup = false, this.isSelection = false});

  final bool isPopup;
  final bool isSelection;

  @override
  State<NewlabelInput> createState() => _NewlabelInputState();
}

class _NewlabelInputState extends State<NewlabelInput> {
  final TextEditingController newLabelController = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool isAdd = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //
        AppButton(
          onPressed: () {
            if (isAdd) {
              setState(() => isAdd = false);
              newLabelController.clear();
              focusNode.unfocus();
            } else {
              setState(() => isAdd = true);
              focusNode.requestFocus();
            }
          },
          noStyling: true,
          isSquare: true,
          child: AppIcon(isAdd ? closeIcon : Icons.add_rounded, faded: true, size: 18),
        ),
        //
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2, left: 2),
            child: DataInput(
              hintText: 'Add Label',
              onFieldSubmitted: (value) async {
                if (value.trim().isNotEmpty) {
                  await addLabel(value.trim());
                  newLabelController.clear();
                  setState(() => isAdd = false);
                  hideKeyboard();
                }
              },
              onTap: () => setState(() => isAdd = true),
              controller: newLabelController,
              focusNode: focusNode,
              fontSize: 12,
              maxLines: 3,
              textInputAction: TextInputAction.done,
              textCapitalization: TextCapitalization.sentences,
              color: transparent,
              hoverColor: transparent,
              borderRadius: borderRadiusLarge,
              contentPadding: EdgeInsets.only(left: 3, top: 10, bottom: 10),
            ),
          ),
        ),
        //
        if (isAdd)
          AppButton(
            onPressed: () async {
              if (newLabelController.text.trim().isNotEmpty) {
                hideKeyboard();
                addLabel(newLabelController.text.trim());
                newLabelController.clear();
              }
              focusNode.unfocus();
              setState(() => isAdd = false);
            },
            noStyling: true,
            isSquare: true,
            child: AppIcon(Icons.done_rounded, size: 18, faded: true),
          )
        //
      ],
    );
    //
  }
}
