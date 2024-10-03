import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_helpers/navigation.dart';
import '../../../../_providers/_providers.dart';
import '../../../../_widgets/buttons/action.dart';
import '../../../../_widgets/dialogs/app_dialog.dart';
import '../../../../_widgets/forms/input.dart';
import '../../../../_widgets/others/text.dart';
import '../../../../_widgets/others/toast.dart';

Future showPeriodBudgetDialog({required String type, required String key}) {
  TextEditingController amountController = TextEditingController(text: state.input.item.data[key]);

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
            state.input.update(key, amountController.text);
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
