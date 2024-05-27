import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/user/set_user_data.dart';
import '../../../_models/item.dart';
import '../../../_providers/common/input.dart';
import '../../../_providers/providers.dart';
import 'add_link.dart';
import 'link_username.dart';
import 'links_list.dart';
import 'misc.dart';

class Links extends StatelessWidget {
  const Links({super.key, this.item});
  final Item? item;

  @override
  Widget build(BuildContext context) {
    bool isInput = item == null;
    Map data = item != null ? item!.data : state.input.data;

    return Consumer<InputProvider>(builder: (context, input, child) {
      return Visibility(
        visible: data['wa'] != null,
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
              if (isInput) LinkUserName(username: data['wu'] ?? liveUserName().toLowerCase()),
              //
              if (!isInput) LinksOverview(item: item, bgColor: data['c']),
              //
              if (isInput) sph(),
              //
              if (isInput) LinksList(),
              //
              if (isInput) sph(),
              //
              if (isInput) AddLink(),
              //
            ],
          ),
        ),
      );
    });
  }
}
