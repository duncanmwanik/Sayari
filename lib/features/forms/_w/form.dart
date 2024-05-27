import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/common/input.dart';
import '../../../_variables/features.dart';
import 'add_question.dart';
import 'details.dart';
import 'questions_list.dart';

class Forms extends StatelessWidget {
  const Forms({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      return Visibility(
        visible: input.data[feature.forms.lt] != null,
        child: Container(
          margin: itemPadding(top: true, bottom: true),
          padding: itemPaddingMedium(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadiusSmall),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              FormDetails(),
              //
              sph(),
              //
              QuestionsList(),
              //
              sph(),
              //
              AddForm(),
              //
            ],
          ),
        ),
      );
    });
  }
}
