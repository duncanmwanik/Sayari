import 'package:flutter/material.dart';

import '../../../../../__styling/variables.dart';
import '../../../../../_helpers/_common/navigation.dart';
import '../../../../../_widgets/buttons/button.dart';
import '../../../../../_widgets/others/forms/input.dart';
import '../../../../../_widgets/others/icons.dart';

class NewType extends StatefulWidget {
  const NewType({super.key, required this.type, required this.subType});

  final String type;
  final String subType;

  @override
  State<NewType> createState() => _NewlabelInputState();
}

class _NewlabelInputState extends State<NewType> {
  final TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool showSaveButton = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //
        Expanded(
          child: DataInput(
            hintText: 'New Type',
            onFieldSubmitted: (value) async {
              if (value.trim().isNotEmpty) {
                // createItem();
                controller.clear();
                setState(() => showSaveButton = false);
                hideKeyboard();
              }
            },
            onTap: () => setState(() => showSaveButton = true),
            controller: controller,
            focusNode: focusNode,
            textInputAction: TextInputAction.done,
            color: transparent,
            contentPadding: EdgeInsets.all(10),
          ),
        ),
        //
        AppButton(
          onPressed: () async {
            if (showSaveButton) {
              if (controller.text.trim().isNotEmpty) {
                hideKeyboard();
                // // //
              }
              controller.clear();
              focusNode.unfocus();
              setState(() => showSaveButton = false);
            } else {
              setState(() => showSaveButton = true);
              focusNode.requestFocus();
            }
          },
          noStyling: true,
          isSquare: true,
          child: AppIcon(showSaveButton ? Icons.done_rounded : Icons.add_rounded, size: 18),
        )
        //
      ],
    );
    //
  }
}
