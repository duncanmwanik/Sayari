import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/_common/navigation.dart';
import '../../_providers/common/selection.dart';
import '../../_services/hive/local_storage_service.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/items/item_selection.dart';
import '../../_widgets/layout/layout_button.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/others/sync_indicator.dart';
import '../../_widgets/others/search.dart';
import '../../_widgets/others/text.dart';
import '../../_widgets/others/theme.dart';
import '../_notes/_w/note_options.dart';
import '../_tables/_helpers/common.dart';
import '../_tables/table_overview/overview_sheet.dart';
import '../files/user_dp.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: globalBox.listenable(),
        builder: (context, box, widget) {
          String tableId = liveTable();
          bool isATableSelected = tableId != 'none';
          String name =
              isATableSelected ? tableNamesBox.get(tableId, defaultValue: 'Select a table') : 'Select a table';

          return Consumer<SelectionProvider>(builder: (context, selection, child) {
            bool isItemSelection = selection.isSelection;

            return Container(
              margin: partitionPadding(top: true, bottom: true, right: true, left: !isSmallPC()),
              decoration: BoxDecoration(
                color: styler.appColor(0.5),
                borderRadius: BorderRadius.circular(borderRadiusSmall),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  //
                  Container(
                    height: 35,
                    padding: itemPaddingSmall(left: true, right: true, top: true),
                    child: isItemSelection
                        ? SelectedItemOptions()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //
                              Flexible(
                                child: Row(
                                  children: [
                                    //
                                    AppButton(
                                      onPressed: () => openDrawer(),
                                      tooltip: 'Manage Your Spaces',
                                      isSquare: true,
                                      noStyling: true,
                                      child: AppIcon(Icons.sort_rounded),
                                    ),
                                    // selected table name
                                    Flexible(
                                      child: AppButton(
                                        onPressed: () =>
                                            isATableSelected ? showTableOverviewBottomSheet() : openDrawer(),
                                        tooltip: name,
                                        noStyling: true,
                                        borderRadius: borderRadiusCrazy,
                                        smallVerticalPadding: true,
                                        child: AppText(
                                          size: extra,
                                          text: name,
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                    //
                                  ],
                                ),
                              ),
                              //
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  //
                                  CloudSyncIndicator(),
                                  //
                                  Search(),
                                  //
                                  LayoutButton(),
                                  //
                                  QuickThemeChanger(),
                                  //
                                  UserDp(isTiny: true),
                                  //
                                ],
                              ),
                              //
                            ],
                          ),
                  ),
                  //
                  NoteOptions(),
                  //
                ],
              ),
            );
          });
        });
  }
}
