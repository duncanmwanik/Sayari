import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_providers/common/input.dart';
import '../../_providers/providers.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/abcs/dialogs_sheets/bottom_sheet.dart';
import '../../_widgets/items/date.dart';
import '../../_widgets/items/input_actions.dart';
import '../../_widgets/items/items.dart';
import '../../_widgets/others/forms/input.dart';
import '../files/file_overview.dart';
import '_helpers/ontap.dart';
import '_w/add_entry.dart';
import '_w/entries.dart';
import '_w/footer.dart';
import '_w/goals.dart';

Future<void> showPeriodBottomSheet({bool isFull = false}) async {
  await showAppBottomSheet(
    isFull: isFull,
    //
    header: CommonHeaderActions(),
    //
    content: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Consumer<InputProvider>(builder: (context, selection, child) => ImageOverview(isInput: true)),
          //
          Row(
            children: [
              Expanded(
                child: DataInput(
                  inputKey: 't',
                  hintText: 'Title',
                  autofocus: state.input.itemId.isEmpty,
                  fontSize: large,
                  fontWeight: FontWeight.w700,
                  keyboardType: TextInputType.name,
                  filled: false,
                ),
              ),
              Consumer<InputProvider>(
                builder: (context, input, child) => AppButton(
                  tooltip: input.data['h'] == '1' ? 'Show more' : 'Show less',
                  leading: state.input.data['h'] == '1' ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                  onPressed: () => state.input.update(action: 'add', key: 'h', value: input.data['h'] == '1' ? '0' : '1'),
                ),
              ),
            ],
          ),
          //
          Dates(showIcon: false),
          //
          Goals(),
          //
          ItemDetails(),
          //
          sph(),
          //
          AddEntry(),
          //
          sph(),
          //
          Entries(),
          //
          spph(),
          //
        ],
      ),
    ),
    //
    footer: PeriodFooter(),
    //
    whenComplete: () => whenCompletePeriod(),
    //
  );
}
