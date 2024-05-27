import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/global.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_providers/common/input.dart';
import '../../../_providers/providers.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/abcs/dialogs_sheets/app_dialog.dart';
import '../../../_widgets/abcs/dialogs_sheets/dialog_buttons.dart';
import '../../../_widgets/items/picker_type.dart';
import '../../../_widgets/others/forms/input.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../../_widgets/others/toast.dart';
import '../../files/_helpers/upload.dart';
import '../_vars/variables.dart';

Future showPeriodEntryDialog({required String financeType, String? entryId, Map entryData = const {}}) {
  TextEditingController amountController = TextEditingController(text: entryData['a']);
  TextEditingController descriptionController = TextEditingController(text: entryData['d']);

  state.input.setEntryType(entryData['y'] ?? financeType);
  bool isEdit = entryId != null;

  return showAppDialog(
    //
    title: '${isEdit ? 'Edit' : 'Add'} $financeType',
    //
    content: Consumer<InputProvider>(builder: (context, input, child) {
      String entryType = input.entryType.isNotEmpty ? input.entryType : financeType;

      return SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            Row(
              children: [
                AppText(size: extra, text: 'Ksh.', faded: true),
                tpw(),
                Expanded(
                    child: DataInput(
                  controller: amountController,
                  hintText: 'Amount',
                  isNumerals: true,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  autofocus: !isEdit,
                )),
              ],
            ),
            //
            sph(),
            //
            Row(
              children: [
                //
                AppTypePicker(
                  type: feature.finances.t,
                  subType: financeType,
                  initial: entryType,
                  typeEntries: financeType == 'Income'
                      ? financeIncomeTypes
                      : (financeType == 'Expense' ? financeExpenseTypes : financeSavingTypes),
                  onSelect: (chosenType, chosenValue) => state.input.setEntryType(chosenType),
                ),
                //
                spw(),
                //
                AppButton(
                  onPressed: () async => await getFilesToUpload().then((fileMap) {}),
                  tooltip: 'Attach File',
                  noStyling: true,
                  child: AppIcon(Icons.attach_file_rounded, faded: true, size: 18),
                ),
                // /
              ],
            ),
            //
            sph(),
            //
            DataInput(
              controller: descriptionController,
              hintText: 'Description',
              minLines: 2,
              textCapitalization: TextCapitalization.sentences,
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            ),
            //
          ],
        ),
      );
    }),
    //
    actions: [
      //
      ActionButton(
        isCancel: true,
      ),
      //
      ActionButton(
        label: isEdit ? 'Save' : 'Add',
        onPressed: () async {
          if (amountController.text.trim().isNotEmpty) {
            if (isEdit) {
              entryData['a'] = amountController.text;
              entryData['d'] = descriptionController.text;
              entryData['y'] = state.input.entryType;
              state.input.update(action: 'add', key: entryId, value: entryData);
            } else {
              String id = '${financeType.substring(0, 2).toLowerCase()}${getUniqueId()}';
              entryData = {'a': amountController.text, 'd': descriptionController.text, 'y': state.input.entryType};
              state.input.update(action: 'add', key: id, value: entryData);
            }

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
