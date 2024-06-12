import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_helpers/user/set_user_data.dart';
import '../../../../../_providers/common/input.dart';
import '../../../../../_variables/features.dart';
import 'add_link.dart';
import 'header.dart';
import 'links_list.dart';

class Links extends StatelessWidget {
  const Links({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      return Visibility(
        visible: input.data[feature.links.lt] != null,
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
              LinkUserName(username: input.data['wu'] ?? liveUserName().toLowerCase()),
              //
              sph(),
              //
              LinksList(),
              //
              sph(),
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
