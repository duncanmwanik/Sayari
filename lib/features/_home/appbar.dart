import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/helpers.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/_common/navigation.dart';
import '../../_providers/common/selection.dart';
import '../../_providers/providers.dart';
import '../../_services/hive/local_storage_service.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/items/item_selection.dart';
import '../../_widgets/layout/layout_button.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/others/other_widgets.dart';
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

            return SliverAppBar(
              expandedHeight: state.views.isNotes() ? (isNotPhone() ? 80 : 75) : 45,
              toolbarHeight: state.views.isNotes() ? (isNotPhone() ? 80 : 75) : 45,
              floating: true,
              leading: NoWidget(),
              leadingWidth: 0,
              titleSpacing: 0,
              backgroundColor: styler.navColor(),
              surfaceTintColor: isImageTheme() ? styler.appColor(5) : styler.navColor(),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  //
                  if (isItemSelection) SizedBox(height: 45, child: SelectedItemOptions()),
                  //
                  if (!isItemSelection)
                    Container(
                      height: 45,
                      padding:
                          isNotPhone() ? itemPadding(left: true, right: true) : EdgeInsets.only(left: 10, right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //
                          Flexible(
                            child: Row(
                              children: [
                                //
                                AppButton(
                                  onPressed: () => openDrawer(),
                                  isRound: true,
                                  noStyling: true,
                                  tooltip: 'Manage Tables',
                                  child: AppIcon(Icons.sort_rounded),
                                ),
                                // selected table name
                                Flexible(
                                  child: AppButton(
                                    onPressed: () => isATableSelected ? showTableOverviewBottomSheet() : openDrawer(),
                                    noStyling: true,
                                    borderRadius: borderRadiusCrazy,
                                    tooltip: 'About $name',
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
                  // if (isNotPhone()) AppDivider(height: 0),
                  // if (isNotPhone()) ph(5),
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
