import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_models/item.dart';
import '../../_widgets/abcs/dialogs_sheets/bottom_sheet.dart';
import '../../_widgets/items/input_actions.dart';
import '../../_widgets/items/items.dart';
import '../../_widgets/others/others/scroll.dart';
import '../_tables/_helpers/checks_table.dart';
import '../files/file_overview.dart';
import '_helpers/ontap.dart';
import '_w_item/new_item.dart';
import '_w_list/subitems.dart';

Future<void> showListBottomSheet({required Item item, bool isFull = false}) async {
  await showAppBottomSheet(
    isFull: isFull,
    //
    header: CommonHeaderActions(),
    //
    content: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          ImageOverview(item: item),
          //
          InkWell(
            onTap: isAdmin() ? () => onTapTitle(item) : null,
            hoverColor: transparent,
            borderRadius: BorderRadius.circular(borderRadiusSmall),
            child: ItemHeader(item: item),
          ),
          //
          Flexible(
            child: Padding(
              padding: itemPadding(left: true, right: true),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  //
                  tph(),
                  //
                  Flexible(
                    child: ScrollConfiguration(
                      behavior: AppScrollBehavior().copyWith(scrollbars: false),
                      child: ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          //
                          ItemDetails(item: item),
                          //
                          ListOfSubItems(item: item),
                          //
                        ],
                      ),
                    ),
                  ),
                  //
                  sph(),
                  //
                  NewItemInput(item: item),
                  //
                  lpph(),
                  //
                ],
              ),
            ),
          ),
          //
        ],
      ),
    ),
    //
  );
}
