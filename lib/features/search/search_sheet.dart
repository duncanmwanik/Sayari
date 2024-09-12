import 'package:flutter/material.dart';

import '../../__styling/variables.dart';
import '../../_widgets/abcs/dialogs_sheets/bottom_sheet.dart';
import '../../_widgets/others/others/scroll.dart';
import 'search_bar.dart';

Future<void> showSearchSheet() async {
  TextEditingController searchController = TextEditingController();

  await showAppBottomSheet(
    //
    header: SearchHeader(controller: searchController),
    //
    content: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: webMaxWidth),
      child: NoScrollBars(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //
              //
            ],
          ),
        ),
      ),
    ),
    //
  ).whenComplete(() => searchController.dispose());
}
