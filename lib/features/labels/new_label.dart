import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/_common/navigation.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/others/forms/input.dart';
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
  bool showSaveButton = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //
        if (!kIsWeb) widget.isSelection ? spw() : mspw(),
        if (kIsWeb) spw(),
        //
        AppButton(
          onPressed: () {
            if (showSaveButton) {
              setState(() => showSaveButton = false);
              newLabelController.clear();
              focusNode.unfocus();
            } else {
              setState(() => showSaveButton = true);
              focusNode.requestFocus();
            }
          },
          noStyling: true,
          isRound: true,
          child: AppIcon(showSaveButton ? closeIcon : Icons.add_rounded, faded: true, size: 18),
        ),
        //
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: DataInput(
              hintText: 'New Label',
              onFieldSubmitted: (value) async {
                if (value.trim().isNotEmpty) {
                  await addLabel(value.trim());
                  newLabelController.clear();
                  setState(() => showSaveButton = false);
                  hideKeyboard();
                }
              },
              onTap: () => setState(() => showSaveButton = true),
              controller: newLabelController,
              focusNode: focusNode,
              fontSize: 13,
              maxLines: 3,
              textInputAction: TextInputAction.done,
              textCapitalization: TextCapitalization.sentences,
              color: transparent,
              hoverColor: transparent,
              borderRadius: borderRadiusLarge,
              contentPadding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
            ),
          ),
        ),
        //
        if (showSaveButton)
          AppButton(
            onPressed: () async {
              if (newLabelController.text.trim().isNotEmpty) {
                hideKeyboard();
                addLabel(newLabelController.text.trim());
                newLabelController.clear();
              }
              focusNode.unfocus();
              setState(() => showSaveButton = false);
            },
            noStyling: true,
            isRound: true,
            child: AppIcon(Icons.done_rounded, size: 18, faded: true),
          )
        //
      ],
    );
    //
  }
}
