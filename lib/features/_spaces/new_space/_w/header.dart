import 'package:flutter/material.dart';

import '../../../../_helpers/navigation.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/buttons/close.dart';
import '../../../../_widgets/others/text.dart';
import '../../../_notes/_helpers/edit_item.dart';
import '../../_helpers/create_space.dart';

class Header extends StatelessWidget {
  const Header(this.isNewSpace, {super.key});

  final bool isNewSpace;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //
        AppCloseButton(onPressed: () => popWhatsOnTop()),
        //
        Flexible(
          child: AppButton(
            onPressed: () {
              hideKeyboard();
              isNewSpace ? createNewSpace() : editItem();
            },
            child: AppText(text: isNewSpace ? 'Create' : 'Save'),
          ),
        ),
        //
      ],
    );
  }
}
