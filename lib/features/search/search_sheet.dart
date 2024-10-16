import 'package:flutter/material.dart';

import '../../_theme/variables.dart';
import '../../_widgets/others/others/scroll.dart';
import '../../_widgets/sheets/bottom_sheet.dart';
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
