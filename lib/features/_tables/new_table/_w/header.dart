import 'package:flutter/material.dart';

import '../../../../_helpers/_common/navigation.dart';
import '../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../_widgets/others/text.dart';
import '../../../_notes/_helpers/edit_item.dart';
import '../../_helpers/create_table.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.isNewTable});

  final bool isNewTable;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //
        AppCloseButton(onPressed: () => popWhatsOnTop(value: true)),
        //
        Flexible(
          child: AppButton(
            onPressed: () {
              hideKeyboard();
              isNewTable ? createNewTable() : editItem();
            },
            child: AppText(text: isNewTable ? 'Create' : 'Save'),
          ),
        ),
        //
      ],
    );
  }
}
