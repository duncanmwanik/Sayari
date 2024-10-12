import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/global.dart';
import '../../_models/item.dart';
import '../../_providers/_providers.dart';
import '../../_variables/features.dart';
import '../../_widgets/buttons/action.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/forms/input.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';
import '../_notes/_helpers/create_item.dart';
import '../_spaces/_helpers/checks_space.dart';

class NewItemInput extends StatefulWidget {
  const NewItemInput({super.key, required this.item});

  final Item item;

  @override
  State<NewItemInput> createState() => _NewItemInputState();
}

class _NewItemInputState extends State<NewItemInput> {
  final TextEditingController controller = TextEditingController();
  bool showSaveButton = false;
  FocusNode newItemFocusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void prepareInput() async {
    state.input.set(Item(
      parent: widget.item.parent,
      type: feature.tasks,
      id: widget.item.id,
      data: {'o': getUniqueId(), 'z': getUniqueId()},
    ));
  }

  // Allow next item creation
  void prepareNext() async {
    controller.clear();
    newItemFocusNode.requestFocus();
    // The delay prevents a new line from being added.
    await Future.delayed(Duration(seconds: 0), () => controller.clear());
    prepareInput();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isAdmin(),
      child: TapRegion(
        onTapOutside: (event) => setState(() => showSaveButton = false),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            tsph(),
            // Add Button
            if (!showSaveButton) tph(),
            if (!showSaveButton)
              AppButton(
                onPressed: () {
                  prepareInput();
                  setState(() => showSaveButton = true);
                  newItemFocusNode.requestFocus();
                },
                smallVerticalPadding: true,
                smallLeftPadding: true,
                showBorder: widget.item.hasColor(),
                bgColor: widget.item.color(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppIcon(Icons.add_rounded, size: medium, faded: true, bgColor: widget.item.color()),
                    spw(),
                    Flexible(child: AppText(text: 'Add Item', size: small, bgColor: widget.item.color())),
                  ],
                ),
              ),
            // New Item
            if (showSaveButton)
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text Input
                  AppButton(
                    color: styler.listItemColor(bgColor: widget.item.color()),
                    showBorder: true,
                    child: DataInput(
                      onChanged: (value) => state.input.update('t', value.trim()),
                      hintText: 'Task',
                      fontSize: medium,
                      weight: FontWeight.w400,
                      isDense: true,
                      controller: controller,
                      focusNode: newItemFocusNode,
                      maxLines: 6,
                      color: transparent,
                      bgColor: widget.item.color(),
                      hoverColor: transparent,
                      contentPadding: noPadding,
                      textInputAction: TextInputAction.done,
                      textCapitalization: TextCapitalization.sentences,
                      onFieldSubmitted: (value) async {
                        if (value.trim().isNotEmpty) await createItem();
                        prepareNext();
                      },
                    ),
                  ),
                  //
                  sph(),
                  //
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ActionButton(
                        isCancel: true,
                        onPressed: () async {
                          controller.clear();
                          newItemFocusNode.unfocus();
                          setState(() => showSaveButton = false);
                        },
                      ),
                      spw(),
                      ActionButton(
                        onPressed: () async {
                          if (controller.text.trim().isNotEmpty) await createItem();
                          prepareNext();
                        },
                        label: 'Add',
                      ),
                    ],
                  ),
                  //
                ],
              ),
          ],
        ),
      ),
    );
  }
}
