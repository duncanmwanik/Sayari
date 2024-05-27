import 'package:flutter/material.dart';

import '../../../../_helpers/_common/navigation.dart';
import '../../../../_helpers/items/create_item.dart';
import '../../../../_helpers/items/edit_item.dart';
import '../../../../_providers/providers.dart';
import '../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../_widgets/others/text.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //
        AppCloseButton(faded: true),
        //
        Flexible(
          child: AppButton(
            onPressed: () {
              hideKeyboard();
              state.input.itemId.isEmpty ? createItem() : editItem();
            },
            child: AppText(
              text: state.input.itemId.isEmpty ? 'Create' : 'Save',
            ),
          ),
        ),
        //
      ],
    );
  }
}
