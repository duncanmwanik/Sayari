import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_helpers/_common/navigation.dart';
import '../../../../../_providers/providers.dart';
import '../../../../../_widgets/abcs/dialogs_sheets/app_dialog.dart';
import '../../../../../_widgets/abcs/dialogs_sheets/dialog_buttons.dart';
import '../../../../../_widgets/others/forms/input.dart';
import '../../../../../_widgets/others/text.dart';
import '../../../../../_widgets/others/toast.dart';

Future showPeriodBudgetDialog({required String type, required String key}) {
  TextEditingController amountController = TextEditingController(text: state.input.data[key]);

  return showAppDialog(
    //
    title: 'Set $type',
    //
    content: Row(
      children: [
        AppText(size: extra, text: 'Ksh.', faded: true),
        tpw(),
        Expanded(
            child: DataInput(
          controller: amountController,
          hintText: 'Amount',
          isNumerals: true,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          autofocus: true,
        )),
      ],
    ),
    //
    actions: [
      //
      ActionButton(
        isCancel: true,
      ),
      //
      ActionButton(
        label: 'Set',
        onPressed: () async {
          if (amountController.text.trim().isNotEmpty) {
            state.input.update(action: 'add', key: key, value: amountController.text);
            popWhatsOnTop();
          } else {
            showToast(0, 'Enter amount');
          }
        },
      ),
      //
    ],
    //
  );
}
