import 'package:flutter/material.dart';

import '../../../../../__styling/helpers.dart';
import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_helpers/_common/global.dart';
import '../../../../../_models/item.dart';
import '../../../../../_providers/providers.dart';
import '../../../../../_variables/features.dart';
import '../../../../../_widgets/buttons/buttons.dart';
import '../../../../../_widgets/others/forms/input.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/text.dart';
import '../../../../_spaces/_helpers/checks_space.dart';
import '../../../_helpers/create_item.dart';

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
  Widget build(BuildContext context) {
    return Visibility(
      visible: isAdmin(),
      child: Padding(
        padding: paddingM('lr'),
        child: TapRegion(
          onTapOutside: (event) => setState(() => showSaveButton = false),
          child: Column(
            children: [
              //
              // Add Button
              //
              if (!showSaveButton) ph(2),
              if (!showSaveButton)
                Align(
                  alignment: Alignment.topLeft,
                  child: AppButton(
                    color: styler.appColor(1),
                    smallLeftPadding: true,
                    onPressed: () {
                      newItemFocusNode.requestFocus();
                      state.input.setInputData(typ: feature.items.t, id: widget.item.id);
                      setState(() => showSaveButton = true);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppIcon(Icons.add_rounded, size: 18, faded: true, bgColor: widget.item.color()),
                        tpw(),
                        Flexible(
                            child: AppText(
                          size: small,
                          text: 'Add Task',
                          fontWeight: isDark() ? FontWeight.w500 : FontWeight.w600,
                          faded: true,
                          bgColor: widget.item.color(),
                        )),
                      ],
                    ),
                  ),
                ),
              //
              // New Item
              //
              if (showSaveButton)
                Column(
                  children: [
                    // Text Input
                    Container(
                      decoration: BoxDecoration(
                        color: styler.listItemColor(bgColor: widget.item.color()),
                        borderRadius: BorderRadius.circular(borderRadiusSmall),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.3),
                        ),
                      ),
                      child: DataInput(
                        inputKey: 't',
                        hintText: 'Task',
                        fontSize: medium,
                        fontWeight: FontWeight.w400,
                        isDense: true,
                        controller: controller,
                        focusNode: newItemFocusNode,
                        maxLines: 6,
                        color: transparent,
                        bgColor: widget.item.color(),
                        textInputAction: TextInputAction.done,
                        textCapitalization: TextCapitalization.sentences,
                        onFieldSubmitted: (value) async {
                          if (controller.text.trim().isNotEmpty) {
                            await createItem(
                              newSubId: 'i${getUniqueId()}',
                              data_: {'t': controller.text},
                              validate: false,
                            );
                          }

                          // Move to next item input
                          // The delay prevents a new line from being added
                          controller.clear();
                          newItemFocusNode.requestFocus();
                          await Future.delayed(Duration(seconds: 0), () => controller.clear());
                          state.input.setInputData(typ: feature.items.t, id: widget.item.id);
                          //
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
                        //
                        AppButton(
                          onPressed: () async {
                            controller.clear();
                            newItemFocusNode.unfocus();
                            setState(() => showSaveButton = false);
                          },
                          smallVerticalPadding: true,
                          child: AppText(text: 'Cancel', bgColor: widget.item.color(), size: small),
                        ),
                        //
                        spw(),
                        //
                        AppButton(
                          onPressed: () async {
                            if (controller.text.trim().isNotEmpty) {
                              await createItem(
                                newSubId: 'i${getUniqueId()}',
                                data_: {'t': controller.text},
                                validate: false,
                              );
                            }
                            // Move to next item input.
                            // The delay prevents a new line from being added.
                            controller.clear();
                            newItemFocusNode.requestFocus();
                            await Future.delayed(Duration(seconds: 0), () => controller.clear());
                            state.input.setInputData(typ: feature.items.t, id: widget.item.id);
                          },
                          color: styler.accentColor(),
                          smallVerticalPadding: true,
                          child: AppText(text: 'Add', size: small, color: white),
                        ),
                        //
                      ],
                    ),
                    //
                    tph(),
                    //
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
