import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_models/item.dart';
import '../../../_providers/common/input.dart';
import '../../../_providers/providers.dart';
import 'add_question.dart';
import 'details.dart';
import 'overview.dart';
import 'questions_list.dart';

class Forms extends StatelessWidget {
  const Forms({super.key, this.item});
  final Item? item;

  @override
  Widget build(BuildContext context) {
    bool isInput = item == null;
    Map data = item != null ? item!.data : state.input.data;

    return Consumer<InputProvider>(builder: (context, input, child) {
      return Visibility(
        visible: data['qa'] != null,
        child: Container(
          margin: itemPadding(top: true, bottom: isInput),
          padding: itemPaddingMedium(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadiusSmall),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              if (isInput) FormDetails(),
              //
              if (!isInput) FormsOverview(item: item, bgColor: data['c']),
              //
              if (isInput) sph(),
              //
              if (isInput) QuestionsList(),
              //
              if (isInput) sph(),
              //
              if (isInput) AddForm(),
              //
            ],
          ),
        ),
      );
    });
  }
}
