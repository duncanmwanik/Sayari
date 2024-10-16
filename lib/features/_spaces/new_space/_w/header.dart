import 'package:flutter/material.dart';

import '../../../../_helpers/navigation.dart';
import '../../../../_helpers/sync/edit_item.dart';
import '../../../../_widgets/buttons/action.dart';
import '../../_helpers/create.dart';
import 'title.dart';

class Header extends StatelessWidget {
  const Header(this.isNewSpace, {super.key});

  final bool isNewSpace;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //
        Expanded(child: TitleInput(isNewSpace)),
        //
        ActionButton(isCancel: true, label: 'Close'),
        ActionButton(
          label: isNewSpace ? 'Create' : 'Save',
          onPressed: () {
            hideKeyboard();
            isNewSpace ? createNewSpace() : editItem();
          },
        ),
        //
      ],
    );
  }
}
