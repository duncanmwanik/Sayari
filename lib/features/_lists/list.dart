import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/helpers.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_models/item.dart';
import '../../_providers/common/selection.dart';
import '../../_providers/providers.dart';
import '../../_widgets/items/hover_actions.dart';
import '../../_widgets/items/items.dart';
import '../../_widgets/items/selector.dart';
import '../../_widgets/others/others/scroll.dart';
import '../_tables/_helpers/checks_table.dart';
import '../files/file_overview.dart';
import '_helpers/ontap.dart';
import '_w_item/new_item.dart';
import '_w_list/subitems.dart';

// TODOs: code min
class AList extends StatelessWidget {
  const AList({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    print(item.data);
    
    return Consumer<SelectionProvider>(builder: (context, selection, child) {
      bool isSelection = selection.isSelection;
      bool isSelected = selection.isSelected(item.id);
      bool isColumn = state.views.isColumn();

      return Align(
        alignment: Alignment.topCenter,
        child: MouseRegion(
          onEnter: (event) => state.hover.updateId(item.id),
          onExit: (event) => state.hover.updateId(''),
          child: Stack(
            children: [
              //
              Card(
                elevation: 0,
                margin: kIsWeb ? itemPaddingMedium() : EdgeInsets.zero,
                color: styler.getItemColor(item.bgColor(), false, isShadeColor: true),
                surfaceTintColor: Colors.amber,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: isSelected ? styler.accentColor() : Colors.grey.withOpacity(styler.isDark && !isBlackTheme() ? 0.05 : 0.4),
                    width: isSelected ? 2 : (styler.isDark ? 0.3 : 0.7),
                  ),
                  borderRadius: BorderRadius.circular(borderRadiusSmall),
                ),
                child: InkWell(
                  onTap: isAdmin() && selection.isSelection ? () => onTapList(item) : null,
                  onLongPress: isAdmin() && !isSelected ? () => onLongPressList(item) : null,
                  mouseCursor: SystemMouseCursors.basic,
                  borderRadius: BorderRadius.circular(borderRadiusSmall),
                  hoverColor: styler.appColor(isImageTheme() ? 0.5 : (styler.isDark ? 0.1 : 0.3)),
                  child: IgnorePointer(
                    ignoring: isSelection,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //
                        ImageOverview(item: item),
                        //
                        InkWell(
                          onTap: isAdmin() ? () => onTapTitle(item) : null,
                          onLongPress: isAdmin() && !isSelected ? () => onLongPressTitle(item) : null,
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
                                      physics: isColumn ? TopBlockedBouncingScrollPhysics() : NeverScrollableScrollPhysics(),
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
                                if (!kIsWeb) sph(),
                                //
                              ],
                            ),
                          ),
                        ),
                        //
                        if (kIsWeb && isNotPhone()) tph(),
                        if (kIsWeb && isNotPhone()) HoverActions(item: item, showMore: isColumn),
                        //
                      ],
                    ),
                  ),
                ),
              ),
              //
              ItemSelector(item: item),
              //
            ],
          ),
        ),
      );
    });
  }
}
