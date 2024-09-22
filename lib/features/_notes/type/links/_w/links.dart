import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_providers/input.dart';
import '../../../../../_variables/features.dart';
import '../../../../../_widgets/others/others/divider.dart';
import 'add_link.dart';
import 'header.dart';
import 'links_list.dart';

class Links extends StatelessWidget {
  const Links({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      return Visibility(
        visible: input.data[feature.links] != null,
        child: Container(
          margin: padding(s: 'tb'),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadiusSmall),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              LinkHeader(),
              //
              AppDivider(),
              //
              LinksList(),
              //
              AddLink(),
              //
            ],
          ),
        ),
      );
    });
  }
}
