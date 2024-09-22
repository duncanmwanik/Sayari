import 'package:flutter/material.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_helpers/_common/global.dart';
import '../../../../../_models/item.dart';
import '../../../../../_providers/_providers.dart';
import '../../../../../_variables/features.dart';
import '../../../../../_widgets/buttons/button.dart';
import '../../../../../_widgets/others/forms/input.dart';
import '../../../../../_widgets/others/text.dart';
import '../../../../_spaces/_helpers/checks_space.dart';
import '../../../_helpers/create_item.dart';

final TextEditingController controller = TextEditingController();
FocusNode newItemFocusNode = FocusNode();

class NewItemInput extends StatelessWidget {
  const NewItemInput({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isAdmin(),
      child: Column(
        children: [
          // Text Input
          Container(
            decoration: BoxDecoration(
              color: styler.listItemColor(bgColor: item.color()),
              borderRadius: BorderRadius.circular(borderRadiusSmall),
              border: Border.all(
                color: Colors.grey.withOpacity(0.3),
              ),
            ),
            child: DataInput(
              inputKey: 't',
              hintText: 'Task',
              fontSize: medium,
              weight: FontWeight.w400,
              isDense: true,
              controller: controller,
              focusNode: newItemFocusNode,
              maxLines: 6,
              color: transparent,
              bgColor: item.color(),
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
                state.input.setInputData(typ: feature.items, id: item.id);
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
                  //
                },
                smallVerticalPadding: true,
                child: AppText(text: 'Cancel', bgColor: item.color(), size: small),
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
                  state.input.setInputData(typ: feature.items, id: item.id);
                },
                color: styler.accentColor(),
                smallVerticalPadding: true,
                child: AppText(text: 'Add', size: small, color: white),
              ),
              //
            ],
          ),
          //
        ],
      ),
    );
  }
}
