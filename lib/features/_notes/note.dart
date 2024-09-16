import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/helpers.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_models/item.dart';
import '../../_providers/common/selection.dart';
import '../../_providers/providers.dart';
import '../../_widgets/others/others/divider.dart';
import '../files/overview.dart';
import '_helpers/ontap.dart';
import '_w/text_overview.dart';
import 'items/details.dart';
import 'items/header.dart';
import 'type/bookings/_w/overview.dart';
import 'type/finance/_w/overview.dart';
import 'type/habits/overview.dart';
import 'type/links/_w/overview.dart';
import 'type/tasks/task.dart';

class Note extends StatelessWidget {
  const Note({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectionProvider>(builder: (_, selection, __) {
      bool isSelected = selection.isSelected(item.id);
      bool isGrid = state.views.isGrid();
      bool isRow = state.views.isRow();

      return SizedBox(
        width: isRow ? 500 : (isTabAndBelow() ? 45.w : 250),
        height: isGrid ? 370 : null,
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 200),
          child: MouseRegion(
            onEnter: (event) => state.hover.set(item.id),
            onExit: (event) => state.hover.reset(),
            child: Card(
              elevation: 0,
              margin: EdgeInsets.zero,
              color: styler.getItemColor(item.color(), false, isShadeColor: true),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadiusTinySmall),
                side: BorderSide(
                  color: isSelected ? styler.accentColor() : Colors.grey.withOpacity(0.4),
                  width: isSelected ? 2 : (styler.isDark ? 0.3 : 0.7),
                ),
              ),
              child: InkWell(
                onTap: () => onTapNote(item),
                onLongPress: isSelected ? null : () => onLongPressNote(item),
                borderRadius: BorderRadius.circular(borderRadiusTinySmall),
                hoverColor: styler.appColor(isImage() ? 0.5 : (styler.isDark ? 0.2 : 0.3)),
                focusColor: transparent,
                splashColor: transparent,
                highlightColor: transparent,
                child: IgnorePointer(
                  ignoring: selection.isSelection,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //
                      ImageOverview(item: item),
                      ItemHeader(item: item),
                      tph(),
                      Padding(
                        padding: paddingS('lr'),
                        child: AppDivider(height: 0, thickness: 1, color: styler.appColor(isDark() ? 1 : 1.5)),
                      ),
                      //
                      Flexible(
                        child: Padding(
                          padding: padding(s: 'lrb'),
                          child: SingleChildScrollView(
                            padding: EdgeInsets.zero,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //
                                ItemDetails(item: item),
                                if (item.hasFinances()) FinanceOverview(item: item),
                                if (item.hasBookings()) BookingOverview(item: item),
                                if (item.hasHabits()) HabitOverview(item: item),
                                if (item.hasLinks()) LinksOverview(item: item),
                                if (item.showEditorOverview()) Flexible(child: NoteTextOverview(item: item)),
                                if (item.isTask()) Flexible(child: NoteTask(item: item)),
                                // if (item.isShared() && !isShare()) tph(),
                                // if (item.isShared() && !isShare()) PreviewNote(item: item),
                                // temp
                                // if (item.id == '1724578910529' && !isShare()) sph(),
                                // if (item.id == '1724578910529' && !isShare())
                                //   PreviewNote(
                                //     item: item,
                                //     label: 'View Published Book',
                                //     path: '/${features[feature.space.lt]!.path}/${liveSpace()}',
                                //   ),
                                //
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
